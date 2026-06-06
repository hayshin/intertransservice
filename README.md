# sv

Everything you need to build a Svelte project, powered by [`sv`](https://github.com/sveltejs/cli).

## Creating a project

If you're seeing this, you've probably already done this step. Congrats!

```sh
# create a new project in the current directory
npx sv create

# create a new project in my-app
npx sv create my-app
```

## Developing

Once you've created a project and installed dependencies with `npm install` (or `pnpm install` or `yarn`), start a development server:

```sh
npm run dev

# or start the server and open the app in a new browser tab
npm run dev -- --open
```

## Building

To create a production version of your app:

```sh
npm run build
```

You can preview the production build with `npm run preview`.

## Deploying to production

**Production site:** https://intertransservice.kz  
**Production repository:** `hayshin/intertransservice` (GitHub Actions → GitHub Pages)

### One-command deploy

```sh
npm run deploy
```

This will:

1. `git add .`
2. `git commit` (only if there are changes)
3. `git push origin master` → triggers production deploy

Optional commit message:

```sh
npm run deploy -- -Message "feat: update hero section"
```

### Git remotes (important)

| Remote | Repository | Purpose |
|--------|------------|---------|
| `origin` | `hayshin/intertransservice` | **Production deploy only** |
| `fork` | `b95236027-wq/intertransservice` | Optional backup (does **not** update the live site) |

**Production deploy ONLY via `origin` (`hayshin/intertransservice`).**  
Pushing only to `fork` does not update intertransservice.kz.

First-time setup after clone:

```sh
npm run setup:git
```

Optional backup sync:

```sh
npm run deploy:backup
```

Track deploy status: https://github.com/hayshin/intertransservice/actions
