
function pyinit {
    $pipenv = "pipenv.exe"
    Get-Command $pipenv -ErrorAction SilentlyContinue | Out-Null
    if ($? -eq $false) {
        Write-Output "$pipenv が見つかりません。"
        return
    }

    $base_dev_packages = @(
        'autopep8',
        'flake8-isort'
    )

    $base_dev_packages | ForEach-Object {
        Invoke-Expression "$pipenv install --dev $_"
    }

    Invoke-Expression "$pipenv shell"
}
