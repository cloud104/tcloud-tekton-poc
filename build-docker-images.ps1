#. aspnet-core\build\build-with-ng.ps1

$execPath = Split-Path $($MyInvocation.MyCommand.Path) -Parent

$aspnetCorePath = Join-Path $execPath "aspnet-core"

$projectsToBuild = @(
    [PSCustomObject]@{
        name      = "TCloudUptime.Migrator"        
        folder    = "$($aspnetCorePath)\src\TCloudUptime.Migrator" 
        imageName = "southamerica-east1-docker.pkg.dev/t-cloud-watch/tcloud-watch/tcloud-uptime-migrator"        
    },
    [PSCustomObject]@{
        name      = "TCloudUptime.Web.Host"
        folder    = "$($aspnetCorePath)\src\TCloudUptime.Web.Host" 
        imageName = "southamerica-east1-docker.pkg.dev/t-cloud-watch/tcloud-watch/tcloud-uptime-webapi"
    },
    [PSCustomObject]@{
        name      = "TCloudUptime.QueueWorker"
        folder    = "$($aspnetCorePath)\src\TCloudUptime.QueueWorker" 
        imageName = "southamerica-east1-docker.pkg.dev/t-cloud-watch/tcloud-watch/tcloud-uptime-queueworker"
    },
    [PSCustomObject]@{
        name      = "TCloudUptime.AlertsManager"
        folder    = "$($aspnetCorePath)\src\TCloudUptime.AlertsManager" 
        imageName = "southamerica-east1-docker.pkg.dev/t-cloud-watch/tcloud-watch/tcloud-uptime-alertsmanager"
    },
    [PSCustomObject]@{
        name      = "TCloudUptime.MonitorSchedulerWorker"
        folder    = "$($aspnetCorePath)\src\TCloudUptime.MonitorSchedulerWorker" 
        imageName = "southamerica-east1-docker.pkg.dev/t-cloud-watch/tcloud-watch/tcloud-uptime-monitorschedulerworker"
    }
)

$createdbyLabel = "com.microsoft.created-by=visual-studio"

foreach ($project in $projectsToBuild) {
    $productLabel = "com.microsoft.visual-studio.project-name=$($project.name)"
    $projectDockerFile = "$($project.folder)\Dockerfile"
    $projectImageName = $project.imageName

    $imageSearch = $(& docker image ls $projectImageName --format "table {{.Repository}}")
    $imageExists = $projectImageName -match $imageSearch[1]

    if ($imageExists) {
        & docker rmi $project.imageName -f
    }   
    
    & docker build -f $projectDockerFile --force-rm -t $projectImageName --label $createdbyLabel --label  $productLabel $aspnetCorePath
}

& docker image prune -f






