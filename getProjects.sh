organization="TTX"
pat="${ado_pat}"
url="https://dev.azure.com/$organization/_apis/projects?api-version=6.0"
projectsJson=$(curl -u ":$pat" -H "Content-Type: application/json" -X GET $url)
echo $projectsJson | jq '.value | .[] | "\(.id) \(.name)" ' | tr -d '"' | while read -r id name ; do
    echo "id:$id;name:$name"
    # your code goes here
done
