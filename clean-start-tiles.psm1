#
# This sets the unpin command to search for.
#
$UNPIN_LABEL = "Unpin from Start"

#
# Gets all of the COM Application objects.
#
# Each of these will have a child with `verbs` to `pin/unpin` (i.e. Right-Click GUI actions).
#
function Get-ApplicationObjects ()
{
    #Magic Number; Doesn't cover all live tiles. TODO: find ids for other tiles.
    $COM_ID_Applications = '{4234d49b-0245-4df3-b780-3893943456e1}'

    $obj = New-Object -Com Shell.Application
    return $obj.NameSpace("shell:::$COM_ID_Applications")
}

#
# Gets the `Unpin...` Verb for an element of `Get-Application-Objects`
#
function Get-UnpinVerb ($item)
{
  return $item.Verbs() | ?{$_.Name.replace('&','') -match "$UNPIN_LABEL"}
}

#
# Filter `Get-Application-Objects` for elements with a valid `Get-Verb-Unpin`.
#
function Get-UnpinnableApps()
{
  $apps = Get-ApplicationObjects
  return $apps.Items() | ?{Get-UnpinVerb($_)}
}

#
# Execute the unpin verb for an application node.
#
function Use-Unpin($item)
{
  $verb = Get-UnpinVerb($item)
  $verb.DoIt()
}

#
# Execute the unpin for all unpinnable apps
#
function Use-UnpinAll()
{
  Get-Unpinnable-Apps | %{ Use-Unpin($_) }
}

#
# List Unpinnable apps to the console.
#
function Show-UnpinnableApps()
{
  echo "
  Applications With '$UNPIN_LABEL':
  "

  Get-UnpinnableApps | %{'    ' + $_.Name}
}

#
# A simple CLI confirm/cancel loop.
#
function Use-Guard([string]$prompt)
{
  $message =
  "
  ${prompt}? [y/n]
  "

  do
  {
    $confirmation = Read-Host $message
    if ($confirmation -eq 'n') {exit}
  }
  while($confirmation -ne "y");
}

#
# CLI command to remove all start tiles
#
# @option -y Disable user prompts
#
function Remove-StartTiles
{
  param(
    $y = 0
  )

  Show-UnpinnableApps

  if ( -not $y ) {Use-Guard("Clear All")}

  echo '
  Cleaning:
  '
  Use-UnpinAll
}

Export-ModuleMember -function Show-StartTiles
Export-ModuleMember -function Remove-StartTiles
