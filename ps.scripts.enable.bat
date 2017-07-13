::
:: [Powershell Config] enable scripts to be run for this user (disabled by default).
::
:: NOTE: `Unrestricted` still requires a prompt for scripts from internet.

powershell -Command Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Unrestricted

:: For user verification of results.
powershell -Command Get-ExecutionPolicy -List

:: Hold terminal open after completion (for point-and-click users).
@pause