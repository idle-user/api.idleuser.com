<?php
declare(strict_types=1);

namespace App\Domain\Matches\Service;

use App\Domain\Matches\Data\MatchRating;
use App\Domain\Matches\Exception\InvalidMatchException;
use App\Domain\Matches\Exception\InvalidMatchRatingException;
use App\Domain\Matches\Exception\MatchRatingNotAvailableException;
use App\Domain\Matches\Repository\EventRepository;
use App\Domain\Matches\Repository\MatchRatingRepository;
use App\Domain\Matches\Repository\MatchRepository;
use App\Domain\Matches\Repository\SeasonRepository;
use Psr\Log\LoggerInterface;

final class AddMatchRatingService
{
    protected $matchRatingRepository;
    protected $matchRepository;
    protected $seasonRepository;
    protected $eventRepository;

    public function __construct(
        LoggerInterface       $logger,
        MatchRatingRepository $matchRatingRepository,
        MatchRepository       $matchRepository,
        SeasonRepository      $seasonRepository,
        EventRepository       $eventRepository
    )
    {
        $this->logger = $logger;
        $this->matchRatingRepository = $matchRatingRepository;
        $this->matchRepository = $matchRepository;
        $this->seasonRepository = $seasonRepository;
        $this->eventRepository = $eventRepository;
    }

    public function run(int $userId, int $matchId, float $rating)
    {
        $rating = MatchRating::create()
            ->setUserId($userId)
            ->setMatchId($matchId)
            ->setRating($rating);

        $this->logger->debug('Match Rating attempt:', $rating->jsonSerialize());

        $this->validate($rating);

        $this->matchRatingRepository->add($rating);
        $this->matchRepository->updateCalculations($rating->getMatchId());

        $rating = $this->matchRatingRepository->findById($userId, $matchId);

        $this->logger->info('Match Rating added:', $rating->jsonSerialize());

        return $rating;
    }

    private function validate(MatchRating $rating)
    {
        if ($rating->getRating() < 0 || $rating->getRating() > 5) {
            throw new InvalidMatchRatingException();
        }

        $match = $this->matchRepository->findById($rating->getMatchId());

        if ($match->getMatchTypeId() == 0) {
            throw new InvalidMatchException();
        }

        if ($match->getTeamWon() == 0) {
            throw new MatchRatingNotAvailableException();
        }

        $matchEvent = $this->eventRepository->findById($match->getEventId());

        if (!$matchEvent->isToday()) {
            throw new MatchRatingNotAvailableException();
        }

        $currentSeason = $this->seasonRepository->findCurrentSeason();
        $matchSeason = $this->seasonRepository->findByMatchId($match->getId());

        if ($currentSeason->getId() != $matchSeason->getId()) {
            throw new InvalidMatchException();
        }
    }
}
