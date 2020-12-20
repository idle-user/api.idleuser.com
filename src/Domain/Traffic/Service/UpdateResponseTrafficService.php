<?php

declare(strict_types=1);

namespace App\Domain\Traffic\Service;

use App\Domain\Traffic\Data\Traffic;
use App\Domain\Traffic\Service\TrafficService;
use Psr\Http\Message\ResponseInterface as Response;

final class UpdateResponseTrafficService extends TrafficService
{
    public function run(Traffic $traffic, Response $response)
    {
        $trafficId = $traffic->getId();
        $responseCode = $response->getStatusCode();

        $this->trafficRepository->updateResponseCode($trafficId, $responseCode);

        $traffic = $this->trafficRepository->findById($trafficId);

        return $traffic;
    }
}
