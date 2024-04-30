import { makeExtendSchemaPlugin, gql } from "postgraphile/utils";
import { each, applyTransforms, loadOne, object } from "grafast";

export const MyPlugin = makeExtendSchemaPlugin((build) => {
  const { languages } = build.input.pgRegistry.pgResources;

  return {
    typeDefs: gql`
      extend type User {
        totalLanguages: Int
      }
    `,

    plans: {
      User: {
        totalLanguages() {
          const $allLanguages = languages.find();
          const $materializedLanguages = each($allLanguages, (lg) =>
            object({ language: lg.get("language") })
          );
          const $objs = applyTransforms($materializedLanguages);

          const $res = loadOne($objs, (allObjs) =>
            allObjs.map((x) => allObjs.length)
          );

          return $res;
        },
      },
    },
  };
});
