import { makeExtendSchemaPlugin, gql } from "postgraphile/utils";
import { each, applyTransforms, loadOne, object, constant, lambda } from "grafast";

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

          // each step seems to cause memory spike
          const $materializedLanguages = each($allLanguages, (lg) =>
            constant(42)
          );

          return lambda($materializedLanguages, () => 1);
        },
      },
    },
  };
});
