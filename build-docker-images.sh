#!/bin/bash

execPath=$(dirname "$0")
aspnetCorePath="$execPath/aspnet-core"

projectsToBuild=(
    [name]="TCloudUptime.Migrator"
    [folder]="$aspnetCorePath/src/TCloudUptime.Migrator"
    [imageName]="southamerica-east1-docker.pkg.dev/t-cloud-watch/tcloud-watch/tcloud-uptime-migrator"
    ,
    [name]="TCloudUptime.Web.Host"
    [folder]="$aspnetCorePath/src/TCloudUptime.Web.Host"
    [imageName]="southamerica-east1-docker.pkg.dev/t-cloud-watch/tcloud-watch/tcloud-uptime-webapi"
    ,
    [name]="TCloudUptime.QueueWorker"
    [folder]="$aspnetCorePath/src/TCloudUptime.QueueWorker"
    [imageName]="southamerica-east1-docker.pkg.dev/t-cloud-watch/tcloud-watch/tcloud-uptime-queueworker"
    ,
    [name]="TCloudUptime.AlertsManager"
    [folder]="$aspnetCorePath/src/TCloudUptime.AlertsManager"
    [imageName]="southamerica-east1-docker.pkg.dev/t-cloud-watch/tcloud-watch/tcloud-uptime-alertsmanager"
    ,
    [name]="TCloudUptime.MonitorSchedulerWorker"
    [folder]="$aspnetCorePath/src/TCloudUptime.MonitorSchedulerWorker"
    [imageName]="southamerica-east1-docker.pkg.dev/t-cloud-watch/tcloud-watch/tcloud-uptime-monitorschedulerworker"
)

createdbyLabel="com.microsoft.created-by=visual-studio"

for project in "${projectsToBuild[@]}"; do
    productLabel="com.microsoft.visual-studio.project-name=${project[name]}"
    projectDockerFile="${project[folder]}/Dockerfile"
    projectImageName="${project[imageName]}"

    imageSearch=$(docker image ls "$projectImageName" --format "table {{.Repository}}")
    if [[ $imageSearch =~ $projectImageName ]]; then
        docker rmi "$projectImageName" -f
    fi

    docker build -f "$projectDockerFile" --force-rm -t "$projectImageName" --label "$createdbyLabel" --label "$productLabel" "$aspnetCorePath"
done

docker image prune -f
