# Setup

## UI

```
cd ui && npm install
```

## Desk

start a fake ship, e.g. `~lur`, then set up the desks:

```
|merge %garden our %base
|mount %garden
|merge %lure our %base
|mount %lure
```

then, sync the desks:

```
./ops/garden.sh
./ops/desk.sh
```

finally, commit and install:

```
|commit %garden
|commit %lure
|install our %garden
|install our %lure
```

# Running

start the fake ship, then:

```
cd ui && npm start
```
