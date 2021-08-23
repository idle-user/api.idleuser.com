<?php
declare(strict_types=1);

namespace App\Domain\Matches\Service;

use App\Domain\Matches\Data\Bet;
use App\Domain\Matches\Exception\BetsClosedException;
use App\Domain\Matches\Exception\InsufficientPointsAvailableException;
use App\Domain\Matches\Exception\MatchEventPassedException;
use App\Domain\Matches\Exception\MatchSeasonInvalidException;
use App\Domain\Matches\Repository\BetRepository;
use Psr\Log\LoggerInterface;
use App\Domain\Matches\Exception\InvalidBetAmountException;
use App\Domain\Matches\Exception\InvalidMatchException;
use App\Domain\Matches\Exception\InvalidBetUpdateException;
use App\Domain\Matches\Repository\ContestantRepository;
use App\Domain\Matches\Repository\EventRepository;
use App\Domain\Matches\Repository\MatchRepository;
use App\Domain\Matches\Repository\SeasonRepository;
use App\Domain\Matches\Repository\StatsRepository;

final class UpdateBetService
{
    protected $betRepository;
    protected $matchRepository;
    protected $statsRepository;
    protected $seasonRepository;
    protected $eventRepository;

    public function __construct(
        LoggerInterface $logger,
        BetRepository $betRepository,
        MatchRepository $matchRepository,
        StatsRepository $statsRepository,
        SeasonRepository $seasonRepository,
        EventRepository $eventRepository
    ) {
        $this->logger = $logger;
        $this->betRepository = $betRepository;
        $this->matchRepository = $matchRepository;
        $this->statsRepository = $statsRepository;
        $this->seasonRepository = $seasonRepository;
        $this->eventRepository = $eventRepository;
    }

    public function run(int $userId, int $matchId, int $team, $points)
    {
        $bet = Bet::create()
            ->setUserId($userId)
            ->setMatchId($matchId)
            ->setTeam($team)
            ->setPoints($points);

        $this->logger->info('Update Bet attempt:', $bet->jsonSerialize());

        $this->validate($bet);

        $this->betRepository->update($bet);

        $bet = $this->betRepository->findById($userId, $matchId);

        $this->logger->info('Bet updated:', $bet->jsonSerialize());

        return $bet;
    }

    private function validate(Bet $bet)
    {
        if ($bet->getPoints() <= 0) {
            throw new InvalidBetAmountException();
        }

        $match = $this->matchRepository->findById($bet->getMatchId());

        if ($match->getMatchTypeId() == 0) {
            throw new InvalidMatchException();
        }

        if ($match->getBetOpen() == 0) {
            throw new BetsClosedException();
        }

        $matchEvent = $this->eventRepository->findById($match->getEventId());

        if ($matchEvent->hasPassed() && !$matchEvent->isToday()) {
            throw new MatchEventPassedException();
        }

        $currentSeason = $this->seasonRepository->findCurrentSeason();
        $matchSeason = $this->seasonRepository->findByMatchId($match->getId());

        if ($currentSeason->getId() != $matchSeason->getId()) {
            throw new MatchSeasonInvalidException();
        }

        $previousBet = $this->betRepository->findById($bet->getUserId(), $bet->getMatchId());

        if (
            !(
                $previousBet->getMatchId() == $bet->getMatchId() &&
                $previousBet->getUserId() == $bet->getUserId() &&
                $previousBet->getTeam() == $bet->getTeam() &&
                $previousBet->getPoints() < $bet->getPoints()
            )
        ) {
            throw new InvalidBetUpdateException();
        }

        $seasonStats = $this->statsRepository->findById($bet->getUserId(), $currentSeason->getId());

        if ($seasonStats->getAvailablePoints() + $previousBet->getPoints() < $bet->getPoints()) {
            throw new InsufficientPointsAvailableException();
        }
    }
}
