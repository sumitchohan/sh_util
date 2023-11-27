organization="TTX"
pat="${ado_pat}"
url="https://dev.azure.com/$organization/_apis/projects?api-version=6.0"
projectsJson=$(curl -u ":$pat" -H "Content-Type: application/json" -X GET $url)
echo "Project Id, Project Name, Repo Id, Repo Name, Repo Url" >  repositories.csv
echo $projectsJson | jq '.value | .[] | "\(.id) \(.name)"' | tr -d '"\r' |  while read -r projectId projectName ; do
    echo "getting details for projectId = $projectId and name=$projectName"   
    url="https://dev.azure.com/$organization/$projectId/_apis/git/repositories?api-version=6.0" 
    repositories=$(curl -u ":$pat" -H "Content-Type: application/json" -X GET $url) 
    echo $repositories | jq '.value | .[] | "\(.id) \(.name) \(.url)" ' | tr -d '"'  | while read -r repoId repoName repoUrl ; do
        echo "$projectId,$projectName,$repoId,$repoName,$repoUrl" | tr -d '\n' >>  repositories.csv
    done 
done 
