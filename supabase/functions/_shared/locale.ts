import { SupportedLocales, ValueOf } from "./baseTypes.ts";

export let currentLocale: SupportedLocales = "tr";

export const Locale = {
  tr: {
    youHaveANewMessage: "$name adlı kişiden mesajınız var!",
  },
  en: {
    youHaveANewMessage: "You have a new message from $name!",
  },
};

export function initLocale(locale: SupportedLocales) {
  currentLocale = locale;
}

export function _l(
  message: keyof ValueOf<typeof Locale>,
  args?: Record<string, string>,
) {
  const originalString: string = Locale[currentLocale][message];
  let modifiedString: string | undefined;

  if (args) {
    const keys = Object.keys(args);

    keys.forEach((key) => {
      modifiedString = originalString.replaceAll(`$${key}`, args[key]);
    });

    return modifiedString;
  }

  return originalString;
}
