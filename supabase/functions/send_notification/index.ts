import { serve } from "https://deno.land/std@0.131.0/http/server.ts";
import { supabaseClient } from "../_shared/supabaseClient.ts";
import { definitions } from "../_shared/types.ts";

const sendNotification = async (
  fcmToken: string,
  senderInformation: definitions["users"],
  text: string,
) => {
  const headers = new Headers();
  headers.set("Authorization", `key=${Deno.env.get("FIREBASE_SERVER_KEY")}`);
  headers.set("Content-Type", "application/json");
  const body = {
    notification: {
      title: `${senderInformation.username} adlı kişiden mesajınız var!`,
      body: text,
    },
    to: fcmToken,
  };

  return await fetch("https://fcm.googleapis.com/fcm/send", {
    method: "POST",
    headers: headers,
    body: JSON.stringify(body),
  });
};

const getFcmToken = async (userId: string): Promise<string | null> => {
  const fcmTokenRequest = await supabaseClient
    .from<definitions["fcm_token"]>("fcm_token")
    .select("fcm_token")
    .eq("user", userId)
    .single();

  if (fcmTokenRequest.error) {
    return null;
  }
  const fcmToken = fcmTokenRequest.data["fcm_token"];

  return fcmToken;
};

const getSenderInformation = async (
  userId: string,
): Promise<definitions["users"] | null> => {
  const request = await supabaseClient
    .from<definitions["users"]>("users")
    .select("username")
    .eq("id", userId)
    .single();

  if (request.error) {
    return null;
  }

  return request.data;
};

serve(async (req) => {
  const { record } = await req.json();
  const { receiver, user, text } = record;

  const fcmToken = await getFcmToken(receiver);
  const getSender = await getSenderInformation(user);

  if (fcmToken && getSender) {
    await sendNotification(fcmToken, getSender, text);
  } else {
    return new Response("not acceptable", {
      status: 406,
    });
  }

  return new Response("ok", {
    status: 200,
  });
});
