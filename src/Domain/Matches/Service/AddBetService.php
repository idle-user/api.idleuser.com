<?php
declare(strict_types=1);

namespace App\Domain\Matches\Service;

use App\Domain\Matches\Data\Bet;
use App\Domain\Matches\Exception\BetsClosedException;
use App\Domain\Matches\Exception\InsufficientPointsAvailableException;
use App\Domain\Matches\Exception\InvalidBetAmountException;
use App\Domain\Matches\Exception\InvalidMatchException;
use App\Domain\Matches\Exception\MatchEventPassedException;
use App\Domain\Matches\Exception\MatchSeasonInvalidException;
use App\Domain\Matches\Repository\BetRepository;
use App\Domain\Matches\Repository\ContestantRepository;
use App\Domain\Matches\Repository\EventRepository;
use App\Domain\Matches\Repository\MatchRepository;
use App\Domain\Matches\Repository\SeasonRepository;
use App\Domain\Matches\Repository\StatsRepository;
use Psr\Log\LoggerInterface;

final class AddBetService
{
    protected $betRepository;
    protected $matchRepository;
    protected $statsRepository;
    protected $seasonRepository;
    protected $eventRepository;
    protected $contestantRepository;

    public function __construct(
        LoggerInterface      $logger,
        BetRepository        $betRepository,
        MatchRepository      $matchRepository,
        StatsRepository      $statsRepository,
        SeasonRepository     $seasonRepository,
        EventRepository      $eventRepository,
        ContestantRepository $contestantRepository
    )
    {
        $this->logger = $logger;
        $this->betRepository = $betRepository;
        $this->matchRepository = $matchRepository;
        $this->statsRepository = $statsRepository;
        $this->seasonRepository = $seasonRepository;
        $this->eventRepository = $eventRepository;
        $this->contestantRepository = $contestantRepository;
    }

    public function run(int $userId, int $matchId, int $team, $points)
    {
        $bet = Bet::create()
            ->setUserId($userId)
            ->setMatchId($matchId)
            ->setTeam($team)
            ->setPoints($points);

        $this->logger->info('Add Bet attempt:', $bet->jsonSerialize());

        $this->validate($bet);

        $this->betRepository->add($bet);

        $bet = $this->betRepository->findById($userId, $matchId);

        $this->logger->info('Bet added:', $bet->jsonSerialize());

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

        $seasonStats = $this->statsRepository->findById($bet->getUserId(), $currentSeason->getId());

        if ($seasonStats->getAvailablePoints() < $bet->getPoints()) {
            throw new InsufficientPointsAvailableException();
        }

        $this->contestantRepository->findByMatchIdAndTeam($bet->getMatchId(), $bet->getTeam());
    }
}
