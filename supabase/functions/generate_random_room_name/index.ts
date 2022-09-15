import { serve } from "https://deno.land/std@0.131.0/http/server.ts";
import { createClient } from "https://esm.sh/@supabase/supabase-js@1.35.6";
import {
  uniqueNamesGenerator,
  names,
  adjectives,
} from "https://esm.sh/unique-names-generator@4.7.1";

serve(async (req) => {
  const { record } = await req.json();
  const roomId = record?.id ?? 0;

  const client = createClient(
    Deno.env.get("SUPABASE_URL")!,
    Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!,
  );

  const randomName = uniqueNamesGenerator({
    dictionaries: [names, adjectives],
    length: 2,
    separator: " ",
  }).toLowerCase();

  await client
    .from("rooms")
    .update({
      name: randomName,
    })
    .eq("id", roomId);

  return new Response();
});
