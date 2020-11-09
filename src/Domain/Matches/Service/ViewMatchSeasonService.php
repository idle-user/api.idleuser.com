<?php
declare(strict_types=1);

namespace App\Domain\Matches\Service;

use App\Domain\Matches\Repository\MatchRepository;
use App\Domain\Matches\Repository\SeasonRepository;
use Psr\Log\LoggerInterface;

final class ViewMatchSeasonService
{

    protected $matchRepository;
    protected $seasonRepository;

    public function __construct(LoggerInterface $logger, MatchRepository $matchRepository, SeasonRepository $seasonRepository)
    {
        $this->logger = $logger;
        $this->matchRepository = $matchRepository;
        $this->seasonRepository = $seasonRepository;
    }

    public function run(int $matchId)
    {

        $this->validate($matchId);

        $season = $this->seasonRepository->findByMatchId($matchId);

        $this->logger->info("Season for Match `${matchId}` was viewed.");

        return $season;
    }

    private function validate(int $matchId)
    {
        $this->matchRepository->findById($matchId);
    }
}
