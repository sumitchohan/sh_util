organization="TTX"
pat="${ado_pat}"
url="https://dev.azure.com/$organization/_apis/projects?api-version=6.0"
projectsJson=$(curl -u ":$pat" -H "Content-Type: application/json" -X GET $url)
echo $projectsJson | jq '.value | .[] | "\(.id),\(.name)" ' 
