<?php

declare(strict_types=1);

namespace App\Domain\Traffic\Service;

use App\Domain\Traffic\Data\Traffic;

final class UpdateTrafficService extends TrafficService
{
    public function run(Traffic $traffic)
    {
        $this->trafficRepository->update($traffic);

        return $this->trafficRepository->findById($traffic->getId());
    }
}
