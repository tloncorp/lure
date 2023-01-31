/-  reel
/+  default-agent, verb, dbug, *reel
|%
+$  card  card:agent:gall
+$  versioned-state
  $%  state-0
      state-1
  ==
::
::  vic: URL of bait service
::  civ: @p of bait service
::  our-metadata: map from tokens to their metadata
::
+$  state-0
  $:  %0
      vic=@t
      civ=ship
      descriptions=(map cord cord)
  ==
+$  state-1
  $:  %1
      vic=@t
      civ=ship
      our-metadata=(map cord metadata:reel)
  ==
--
=|  state-1
=*  state  -
::
%-  agent:dbug
%+  verb  |
|_  =bowl:gall
+*  this       .
    def        ~(. (default-agent this %|) bowl)
::
++  on-init
  ^-  (quip card _this)
  `this(vic 'https://bait-dev.tlon.io/', civ ~samnec-dozzod-marzod)
::
++  on-save  !>(state)
++  on-load
  |=  old-state=vase
  ^-  (quip card _this)
  =/  old  !<(versioned-state old-state)
  ?-  -.old
      %1
    `this(state old)
      %0
    `this(state *state-1)
  ==
::
++  on-poke
  |=  [=mark =vase]
  ^-  (quip card _this)
  ?+    mark  (on-poke:def mark vase)
      %reel-command
    ?>  =(our.bowl src.bowl)
    =+  !<(=command:reel vase)
    ?-  -.command
        %set-service
      :_  this(vic vic.command)
      ~[[%pass /set-ship %arvo %k %fard q.byk.bowl %reel-set-ship %noun !>(vic)]]
        %set-ship
      `this(civ civ.command)
    ==
  ::
      %reel-bite
    =+  !<(=bite:reel vase)
    [[%give %fact ~[/bites] mark !>(bite)]~ this]
  ::
      %reel-describe
    =+  !<  [token=cord =metadata:reel]  vase
    :_  this(our-metadata (~(put by our-metadata) token metadata))
    ~[[%pass /describe %agent [civ %bait] %poke %bait-describe !>([token metadata])]]
  ==
::
++  on-agent
  |=  [=wire =sign:agent:gall]
  ^-  (quip card _this)
  ?+  wire  (on-agent:def wire sign)
      [%describe ~]
    ?+  -.sign  (on-agent:def wire sign)
        %poke-ack
      ?~  p.sign
        `this
      (on-agent:def wire sign)
    ==
  ==
::
++  on-watch
  |=  =path
  ^-  (quip card _this)
  ?>  =(our.bowl src.bowl)
  ?+  path  (on-watch:def path)
    [%bites ~]  `this
  ==
::
++  on-leave  on-leave:def
++  on-peek
  |=  =path
  ^-  (unit (unit cage))
  ?+  path  [~ ~]
    [%x %service ~]  ``noun+!>(vic)
    [%x %bait ~]  ``reel-bait+!>([vic civ])
::
      [%x %metadata @ ~]
    =/  =metadata:reel  (fall (~(get by our-metadata) i.t.t.path) *metadata:reel)
    ``reel-metadata+!>(metadata)
  ==
::
++  on-arvo
  |=  [=wire sign=sign-arvo]
  ^-  (quip card:agent:gall _this)
  ?>  ?=([%set-ship ~] wire)
  ?>  ?=([%khan %arow *] sign)
  ?:  ?=(%.n -.p.sign)
    ((slog leaf+<p.p.sign> ~) `this)
  `this
++  on-fail   on-fail:def
--
