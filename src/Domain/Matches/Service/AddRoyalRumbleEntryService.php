<?php
declare(strict_types=1);

namespace App\Domain\Matches\Service;

use App\Domain\Matches\Data\RoyalRumbleEntry;
use App\Domain\Matches\Exception\RoyalRumbleEntriesClosedException;
use App\Domain\Matches\Exception\RoyalRumbleEntryAlreadyExistsException;
use App\Domain\Matches\Exception\RoyalRumbleEntryNotFoundException;
use App\Domain\Matches\Repository\RoyalRumbleEntryRepository;
use App\Domain\Matches\Repository\RoyalRumbleRepository;
use App\Domain\User\Exception\UserNotFoundException;
use App\Domain\User\Repository\UserRepository;
use App\Exception\ValidationException;
use Psr\Log\LoggerInterface;

final class AddRoyalRumbleEntryService
{
    protected $royalRumbleRepository;
    protected $royalRumbleEntryRepository;
    protected $userRepository;

    public function __construct(
        LoggerInterface $logger,
        RoyalRumbleRepository $royalRumbleRepository,
        RoyalRumbleEntryRepository $royalRumbleEntryRepository,
        UserRepository $userRepository
    ) {
        $this->logger = $logger;
        $this->royalRumbleRepository = $royalRumbleRepository;
        $this->royalRumbleEntryRepository = $royalRumbleEntryRepository;
        $this->userRepository = $userRepository;
    }

    public function run(int $royalRumbleId, ?int $userId, ?string $displayName, string $comment)
    {
        $royalRumbleEntry = RoyalRumbleEntry::create()
            ->setRoyalRumbleId($royalRumbleId)
            ->setUserId($userId)
            ->setDisplayName($displayName)
            ->setComment($comment);

        $this->logger->info('Royal Rumble entry attempt:', $royalRumbleEntry->jsonSerialize());

        $this->validate($royalRumbleEntry);
        $this->assignRandomEntryNumber($royalRumbleEntry);

        $this->royalRumbleEntryRepository->add($royalRumbleEntry);

        $royalRumbleEntry = $this->royalRumbleEntryRepository->findById(
            $royalRumbleEntry->getRoyalRumbleId(),
            $royalRumbleEntry->getDisplayName(),
        );

        $this->logger->info('Royal Rumble entry added:', $royalRumbleEntry->jsonSerialize());

        return $royalRumbleEntry;
    }

    private function validate(RoyalRumbleEntry $royalRumbleEntry)
    {
        $royalRumble = $this->royalRumbleRepository->findById($royalRumbleEntry->getRoyalRumbleId());
        if (!is_null($royalRumble->getEntryWon())) {
            throw new RoyalRumbleEntriesClosedException();
        }

        if (is_null($royalRumbleEntry->getUserId())) {
            if (!preg_match('/^[\w\-]+$/i', $royalRumbleEntry->getDisplayName())) {
                throw new ValidationException('Display name is invalid.');
            }
            try {
                $this->userRepository->findByUsername($royalRumbleEntry->getDisplayName());
                throw new ValidationException('Display name already taken.');
            } catch (UserNotFoundException $e) {
            }
        } else {
            $userInfo = $this->userRepository->findById($royalRumbleEntry->getUserId());
            $royalRumbleEntry->setDisplayName($userInfo->getUsername());
        }
    }

    private function assignRandomEntryNumber(RoyalRumbleEntry $royalRumbleEntry)
    {
        $royalRumble = $this->royalRumbleRepository->findById($royalRumbleEntry->getRoyalRumbleId());
        $entryRange = range(1, $royalRumble->getEntryMax());

        if (!is_null($royalRumbleEntry->getUserId())) {
            try {
                $royalRumbleEntryList = $this->royalRumbleEntryRepository->findByRoyalRumbleId($royalRumble->getId());
            } catch (RoyalRumbleEntryNotFoundException $e) {
                $royalRumbleEntryList = [];
            }

            $entriesTaken = [];
            foreach ($royalRumbleEntryList as $entry) {
                if (!is_null($entry->getUserId())) {
                    $entriesTaken[] = $entry->getEntry();
                }
            }
            $entriesTaken = array_unique($entriesTaken);

            if (count($entriesTaken) < $royalRumble->getEntryMax()) {
                $entryRange = array_values(array_diff($entryRange, $entriesTaken));
                $this->logger->info('Royal Rumble entry new range:', $entryRange);
            }
        }

        $entryNumber = $entryRange[array_rand($entryRange)];
        $royalRumbleEntry->setEntry($entryNumber);
    }
}
