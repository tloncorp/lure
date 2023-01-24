/-  lure, groups
/+  default-agent, verb, dbug
::
|%
++  enabled-groups  (set cord)
+$  card  card:agent:gall
+$  versioned-state
  $%  state-0
  ==
+$  state-0  [%0 =enabled-groups]
--
::
=|  state-0
=*  state  -
%-  agent:dbug
^-  agent:gall
|_  =bowl:gall
+*  this  .
    def   ~(. (default-agent this %.n) bowl)
::
++  on-init
  :_  this
  ~[[%pass /bite-wire %agent [our.bowl %lure] %watch /bites]]
++  on-poke
  |=  [=mark =vase]
  ^-  (quip card _this)
  ?+  mark  !!
    %leave  :_  this  ~[[%pass /bite-wire %agent [our.bowl %lure] %leave ~]]
    %watch  :_  this  ~[[%pass /bite-wire %agent [our.bowl %lure] %watch /bites]]
    ::
      %grouper-enable
    =+  !<(name=cord vase)
    `this(enabled-groups (~(put in enabled-groups) name))
      %grouper-disable
    =+  !<(name=cord vase)
    `this(enabled-groups (~(del in enabled-groups) name))
  ==
::
++  on-watch
  |=  =path
  (on-watch:def +<)
::
++  on-agent
  |=  [=wire =sign:agent:gall]
  ^-  (quip card _this)
  ?+    -.sign  !!
      %watch-ack  `this
      %kick       `this
      %fact
    =+  !<(=bait:lure q.cage.sign)
    ?>  (~(has in enabled-groups) token.bait)
    =/  =invite:groups  [[our.bowl token.bait] ship.bait]
    :_  this  
    ~[[%pass /invite %agent [our.bowl %groups] %poke %group-invite !>(invite)]]
  ==
::
++  on-fail
  |=  [=term =tang]
  (mean ':sub +on-fail' term tang)
::
++  on-leave
  |=  =path
  `this
::
++  on-save   !>(state)
++  on-load   |=(old=vase `this(state !<(_state old)))
++  on-arvo   on-arvo:def
++  on-peek   on-peek:def
--
