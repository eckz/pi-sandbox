
- Avoid wasting tokens by filtering the output of the tools (e.g. use `head`, `tail`, `grep`, `rg`, or line limits instead of dumping full output).
- Do not try to commit code to git, or execute any command that modifies the `.git` folder, you don't have permissions for that.
- You are running inside a docker sandbox that get's replaced after every session, so if a dependency is missing it's better that you tell the user that it should be installed permanently

### How to execute user requests

1. If the changes that the user are requesting are trivial, go ahead and do them.
2. If the changes are more complex, first do an exploration and create a plan on what changes would be needed to be done. You don't need to ask the user before executing the exploration phase. Once the plan is built, present the user the plan to approve it before continuing.
