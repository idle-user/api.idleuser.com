<?php
declare(strict_types=1);

namespace App\Domain\Matches\Service;

use App\Domain\Matches\Data\FavoriteSuperstar;
use App\Domain\Matches\Repository\FavoriteSuperstarRepository;
use App\Domain\Matches\Repository\SuperstarRepository;
use Psr\Log\LoggerInterface;

final class AddFavoriteSuperstarService
{
    protected $favoriteSuperstarRepository;
    protected $superstarRepository;

    public function __construct(
        LoggerInterface             $logger,
        FavoriteSuperstarRepository $favoriteSuperstarRepository,
        SuperstarRepository         $superstarRepository
    )
    {
        $this->logger = $logger;
        $this->favoriteSuperstarRepository = $favoriteSuperstarRepository;
        $this->superstarRepository = $superstarRepository;
    }

    public function run(int $userId, int $superstarId)
    {
        $favoriteSuperstar = FavoriteSuperstar::create()
            ->setUserId($userId)
            ->setSuperstarId($superstarId);

        $this->logger->info('Favorite Superstar attempt:', $favoriteSuperstar->jsonSerialize());

        $this->validate($favoriteSuperstar);

        $this->favoriteSuperstarRepository->add($favoriteSuperstar);

        $favoriteSuperstar = $this->matchRatingRepository->findById($favoriteSuperstar->getUserId(), $favoriteSuperstar->getSuperstarId());

        $this->logger->info('Match Rating added:', $favoriteSuperstar->jsonSerialize());

        return $favoriteSuperstar;
    }

    private function validate(FavoriteSuperstar $favoriteSuperstar)
    {
        $this->superstarRepository->findById($favoriteSuperstar->getSuperstarId());
    }
}
