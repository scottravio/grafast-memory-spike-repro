# grafast-memory-spike-repro

Run postgres in docker, install the schema, and add the data

```
make all
```

Run postgraphile in one terminal:

```
pnpm run postgraphile
```

Run ruru in another:

```
pnpm run ruru
```

Run this graphql query:

```
query {
  allUsers {
    nodes {
      rowId
      name
      totalLanguages
    }
  }
}
```

In the console output, observe the JS heap jump significantly when the query is executed going through our plugin.

On my machine (Macbook Pro M1, 32GB RAM, node v20.11.0) I see a jump from ~50mb straight to ~250mb on query execution.

See:



https://github.com/cjheppell/grafast-memory-spike-repro/assets/12884767/be6e428b-4f18-4f63-969c-6de6b8f9562c
