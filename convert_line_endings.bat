@echo off

:: git on Windows may force the line endings of shell scripts to CRLF, which
:: makes them misbehave in the Docker container.
:: The following code converts the line endings to UNIX (LF) recuseively to
:: resolve this issue

pushd ..\src

for /R %%f in (*.sh) do (
	echo Converting line endings to UNIX for: "%%f"
	powershell -command "(Get-Content -Raw '%%f') -replace \"`r\", \"\" | Set-Content -NoNewline '%%f'"
)

popd
