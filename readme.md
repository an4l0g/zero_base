# Zero Base

## Gitflow

### Nomes de Branches

- _fix/name-of-task_: Para manutenções sem urgência que serão mergeadas na branch develop;
- _hotfix/name-of-task_: Para manutenções urgentes que serão mergeadas direto na branch main;
- _feature/name-of-task_: Para criação de novas funcionalidades;
- _chore/name-of-task_: Para pequenas melhorias em uma funcionalidade já criada;

### Padronização de commits

- _fix: description of changes_: Para commits relacionados à uma manutenção no código da branch atual;
- _feat: description of changes_: Para commits que possuem novas funcionalidades;
- _chore: description of changes_: Para commits que possuem novas melhorias para funcionalidades existentes;

### Criando uma nova branch a partir da DEVELOP

- `git clone [link-do-repositorio]` Puxar o projeto para seu PC
- `git checkout develop` Mudar para a branch develop
- `git checkout -b feat/new-feature` Criando uma nova branch a partir da develop
- Agora é só trabalhar nela!!

### Estou em uma branch que não terminei de trabalhar mas preciso trabalhar em outra

- `git add .` Adicionar todas as modificações da branch atual na fila do commit
- `git commit -m 'feat: all changes descriptions'` Commitar criando uma descrição padronizada de acordo com o a padronização de commits ali em cima
- `git pull origin [nome-da-branch]` Puxar todas as modificações que foram feitas na branch no servidor do GIT (caso algum amiguinho esteja mexendo na mesma branch que você)
- `git push origin [nome-da-branch]` Empurrar para o servidor todas as modificações que você commitou na sua máquina desta branch
- `git checkout develop` Voltar para develop
- `git pull origin develop` Trazer todas as modificações que existem na develop
- `git checkout -b [nome-da-nova-branch-que-vou-mexer]` Criando nova branch que vou mexer

### Terminei de mexer em uma branch e quero mergear ela na dev

- `git add .` Adicionando todas as modificações na fila de commit
- `git commit -am "feat: all descriptions changes"` Commitando as modificações
- `git pull origin [nome-da-branch]` Puxando todas as modificações da branch do repositorio do git
- `git push origin [nome-da-branch]` Empurrando todas as modificações da branch da sua máquina para o repositório do git
- Vai aparecer um link na tela quando terminar de subir, você deve clicar nele e gerar uma Pull Request.
