#!/bin/bash
echo What do you want the project to be called
read projectName
npm create svelte@latest $projectName
cd $projectName
npm i
npm install @sveltejs/adapter-static
rm svelte.config.js
cat > /svelte.config.js << ENDOFFILE
import adapter from '@sveltejs/adapter-static';
import { vitePreprocess } from '@sveltejs/vite-plugin-svelte';

/** @type {import('@sveltejs/kit').Config} */
const config = {
	// Consult https://kit.svelte.dev/docs/integrations#preprocessors
	// for more information about preprocessors
	preprocess: vitePreprocess(),

	kit: {
		// adapter-auto only supports some environments, see https://kit.svelte.dev/docs/adapter-auto for a list.
		// If your environment is not supported or you settled on a specific environment, switch out the adapter.
		// See https://kit.svelte.dev/docs/adapters for more information about adapters.
		adapter: adapter({
			pages: 'dist',
			assets: 'dist',
			fallback: null,
			precompress: false,
			strict: true
		})
	}
};

export default config;
ENDOFFILE

cat > /src/routes/+layout.ts <<EOF
export const prerender = true;
EOF

npm i @capacitor/core @capacitor/android
npm i -D @capacitor/cli
npx cap init


echo Every time you make code changes, you then run npm run build and npx cap sync to sync the changes to the android project. Execute that step now.
echo Install Android Studio if you haven't and open the project with npx cap open android. 
echo example for linux npm run build && npx cap sync && npx cap open android:
