::
:: [Powershell Config] disable powershell scripts this user (disabled by default).
::

powershell -Command Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Undefined

:: For user verification of results.
powershell -Command Get-ExecutionPolicy -List

:: Keep terminal open after completion, when opened from gui instead of CLI.
@pause