<?php
declare(strict_types=1);

namespace App\Domain\Pickem\Service;

use App\Domain\Pickem\Data\Pick;
use App\Domain\Pickem\Data\Stats;
use App\Domain\Pickem\Exception\InvalidPromptChoiceException;
use App\Domain\Pickem\Exception\PickAlreadyExistsException;
use App\Domain\Pickem\Exception\PickNotFoundException;
use App\Domain\Pickem\Exception\PromptExpiredException;
use App\Domain\Pickem\Exception\PromptPicksClosedException;
use App\Domain\Pickem\Exception\StatsNotFoundException;
use App\Domain\Pickem\Repository\ChoiceRepository;
use App\Domain\Pickem\Repository\PickRepository;
use App\Domain\Pickem\Repository\PromptRepository;
use App\Domain\Pickem\Repository\StatsRepository;
use Psr\Log\LoggerInterface;

final class AddPickService
{
    protected $promptRepository;
    protected $choiceRepository;
    protected $pickRepository;
    protected $statsRepository;

    public function __construct(
        LoggerInterface  $logger,
        PromptRepository $promptRepository,
        ChoiceRepository $choiceRepository,
        PickRepository   $pickRepository,
        StatsRepository  $statsRepository
    )
    {
        $this->logger = $logger;
        $this->promptRepository = $promptRepository;
        $this->choiceRepository = $choiceRepository;
        $this->pickRepository = $pickRepository;
        $this->statsRepository = $statsRepository;
    }

    public function run(int $userId, int $promptId, int $choiceId)
    {
        $this->validate($userId, $promptId, $choiceId);

        $pick = Pick::create()
            ->setUserId($userId)
            ->setPromptId($promptId)
            ->setChoiceId($choiceId);

        $this->logger->debug('Add Pick attempt:', $pick->jsonSerialize());
        $this->pickRepository->add($pick);
        $pick = $this->pickRepository->find($promptId, $userId);
        $this->logger->info('Pick added:', $pick->jsonSerialize());

        $prompt = $this->promptRepository->findById($promptId);
        $this->logger->debug('Increment Prompt Picks attempt:', $prompt->jsonSerialize());
        $prompt = $prompt->incrementPicks();
        $this->promptRepository->update($prompt);
        $prompt = $this->promptRepository->findById($promptId);
        $this->logger->info('Prompt Picks incremented:', $prompt->jsonSerialize());

        $choice = $this->choiceRepository->findById($choiceId);
        $this->logger->debug('Increment Choice Picks attempt:', $choice->jsonSerialize());
        $choice = $choice->incrementPicks();
        $this->choiceRepository->update($choice);
        $choice = $this->choiceRepository->findById($choiceId);
        $this->logger->info('Prompt Choice Picks incremented:', $choice->jsonSerialize());

        $userStats = $this->statsRepository->find($userId);
        $this->logger->debug('Increment Stats Picks attempt:', $userStats->jsonSerialize());
        $userStats = $userStats->incrementPicks();
        $this->statsRepository->update($userStats);
        $userStats = $this->statsRepository->find($userStats->getUserId());
        $this->logger->info('Stats Picks incremented:', $userStats->jsonSerialize());

        return $pick;
    }

    private function validate(int $userId, int $promptId, int $choiceId): void
    {
        try {
            $this->statsRepository->find($userId);
        } catch (StatsNotFoundException $e) {
            $userStats = Stats::create()->setUserId($userId);
            $this->statsRepository->add($userStats);
            $this->statsRepository->find($userId);
        }

        $prompt = $this->promptRepository->findById($promptId);
        $choice = $this->choiceRepository->findById($choiceId);

        if (!$prompt->isOpen()) {
            throw new PromptPicksClosedException();
        }

        if ($prompt->isExpired()) {
            throw new PromptExpiredException();
        }

        if ($prompt->getId() !== $choice->getPromptId()) {
            throw new InvalidPromptChoiceException();
        }

        try {
            $this->pickRepository->find($promptId, $userId);
            throw new PickAlreadyExistsException();
        } catch (PickNotFoundException $e) {
        }

    }
}
