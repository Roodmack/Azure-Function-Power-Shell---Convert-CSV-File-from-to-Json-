using namespace System.Net
# Input bindings are passed in via param block.
param($Request, $TriggerMetadata)
# Write to the Azure Functions log stream.
Write-Host "PowerShell HTTP trigger function processed a request to convert a CSV file to json ."

if (-not $Base64file) {
    $Base64file = $Request.Body.Base64file
}

"This HTTP triggered function executed successfully. Pass a Base64 encoded CSV file  in the request body for a json response."

if ($Base64file) {
        $body = "  This HTTP triggered function executed successfully, with parameter receive."

        $base64string= $Base64file
        [byte[]]$bytes=[System.Convert]::FromBase64String($base64string)
        $normalstring=[System.Text.Encoding]::UTF8.GetString($bytes)
        $normalstring.count
        $csv = $normalstring | ConvertFrom-Csv
        $json = $csv | ConvertTo-Json -Depth 10
        $body = $json

}

Push-OutputBinding -name Response -Value ([HttpResponseContext]@{
    StatusCode = [HttpStatusCode]::OK
    Body = $body
})
