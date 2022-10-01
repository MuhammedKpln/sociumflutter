import { serve } from "https://deno.land/std@0.131.0/http/server.ts";
import { supabaseClient } from "../_shared/supabaseClient.ts";
import { definitions } from "../_shared/types.ts";
import {
  IFirebaseNotification,
  SupabaseRequest,
  SupportedLocales,
} from "../_shared/baseTypes.ts";
import { initLocale, _l } from "../_shared/locale.ts";

const sendNotification = async (
  fcmToken: string,
  notification: IFirebaseNotification,
) => {
  const headers = new Headers();
  headers.set("Authorization", `key=${Deno.env.get("FIREBASE_SERVER_KEY")}`);
  headers.set("Content-Type", "application/json");

  const body = {
    notification: notification,
    to: fcmToken,
  };

  const request = await fetch("https://fcm.googleapis.com/fcm/send", {
    method: "POST",
    headers: headers,
    body: JSON.stringify(body),
  }).catch((err) => console.log(err));

  return request;
};

const getFcmToken = async (userId: string): Promise<string | null> => {
  const fcmTokenRequest = await supabaseClient
    .from<definitions["fcm_token"]>("fcm_token")
    .select("*")
    .eq("user", userId)
    .single();

  if (fcmTokenRequest.error) {
    return null;
  }
  const fcmToken = fcmTokenRequest.data["fcm_token"];

  return fcmToken;
};

const getUserInformation = async (
  userId: string,
): Promise<Pick<definitions["users"], "username" | "locale"> | null> => {
  const request = await supabaseClient
    .from<definitions["users"]>("users")
    .select("*")
    .eq("id", userId)
    .single();

  if (request.error) {
    return null;
  }

  return request.data;
};

const sendMessageNotification = async ({
  receiver,
  user,
  text,
}: definitions["messages"]) => {
  const fcmToken = await getFcmToken(receiver!);
  const getSender = await getUserInformation(user);
  const getReceiver = await getUserInformation(receiver!);

  if (getReceiver?.locale) {
    initLocale(getReceiver.locale as SupportedLocales);
  }
  if (fcmToken && getSender && getReceiver) {
    const notification: IFirebaseNotification = {
      title: _l("youHaveANewMessage", { name: getSender.username }),
      body: text,
    };
    await sendNotification(fcmToken, notification);
  } else {
    return new Response("not acceptable", {
      status: 406,
    });
  }
};

serve(async (req) => {
  const { record, table } = (await req.json()) as SupabaseRequest;

  switch (table) {
    case "messages":
      await sendMessageNotification(record as definitions["messages"]);
      break;
  }

  return new Response("ok", {
    status: 200,
  });
});
