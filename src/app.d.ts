// See https://svelte.dev/docs/kit/types#app.d.ts
// for information about these interfaces
declare global {
	namespace App {
		// interface Error {}
		// interface Locals {}
		// interface PageData {}
		// interface PageState {}
		// interface Platform {}
	}
}

declare module '$env/dynamic/private' {
	export interface PrivateEnv {
		TELEGRAM_BOT_TOKEN: string;
		TELEGRAM_CHAT_ID: string;
	}
}

export {};
