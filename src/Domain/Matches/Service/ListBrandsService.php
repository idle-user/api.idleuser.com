<?php
declare(strict_types=1);

namespace App\Domain\Matches\Service;

final class ListBrandsService extends BrandService
{
    public function run()
    {
        $brandList = $this->brandRepository->findAll();

        $this->logger->info("Brand list was viewed.");

        return $brandList;
    }
}
