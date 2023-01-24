/-  reel
/+  default-agent, verb, dbug
|%
+$  card  card:agent:gall
+$  versioned-state
  $%  state-0
  ==
::
::  vic: URL of bait service
::  civ: @p of bait service
::
+$  state-0
  $:  %0
      vic=@t
      civ=ship
  ==
--
=|  state-0
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
  ?>  ?=(%0 -.old)
  `this(state old)
::
++  on-poke
  |=  [=mark =vase]
  ^-  (quip card _this)
  ?+    mark  (on-poke:def mark vase)
      %reel-command
    ?>  =(our.bowl src.bowl)
    =+  !<(=command:reel vase)
    `this(vic vic.command)
  ::
      %reel-bite
    =+  !<(=bite:reel vase)
    [[%give %fact ~[/bites] mark !>(bite)]~ this]
      %reel-describe
    :_  this
    =+  !<  [token=cord description=cord]  vase
    ~[[%pass /describe %agent [civ %bait] %poke %describe !>([token description])]]
  ==
::
++  on-agent  on-agent:def
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
    [%x %bait ~]  ``json+!>([%s vic])
  ==
::
++  on-arvo   on-arvo:def
++  on-fail   on-fail:def
--
