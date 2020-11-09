<?php
declare(strict_types=1);

namespace App\Domain\Matches\Service;

final class ViewBrandService extends BrandService
{
    public function run(int $brandId)
    {
        $brand = $this->brandRepository->findById($brandId);

        $this->logger->info("Brand id `${brandId}` was viewed.");

        return $brand;
    }
}
