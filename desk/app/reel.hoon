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
::  descriptions: map from tokens to their descriptions
::
+$  state-0
  $:  %0
      vic=@t
      civ=ship
      descriptions=(map cord cord)
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
  ::
      %reel-describe
    :_  this
    =+  !<  [token=cord description=cord]  vase
    ~[[%pass [%describe token description ~] %agent [civ %bait] %poke %bait-describe !>([token description])]]
  ==
::
++  on-agent
  |=  [=wire =sign:agent:gall]
  ^-  (quip card _this)
  ?+  wire  (on-agent:def wire sign)
      [%describe @ @ ~]
    ?+  -.sign  (on-agent:def wire sign)
        %poke-ack
      ?~  p.sign
        `this(descriptions (~(put by descriptions) i.t.wire i.t.t.wire))
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
    [%x %bait ~]  ``json+!>([%s vic])
    [%x %description @ ~]  ``reel-description+!>((fall (~(get by descriptions) i.t.t.path) ''))
  ==
::
++  on-arvo   on-arvo:def
++  on-fail   on-fail:def
--
