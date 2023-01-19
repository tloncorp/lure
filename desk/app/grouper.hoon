/-  lure, groups
/+  default-agent, verb, dbug
::
|%
++  tokens  (map cord flag:groups)
+$  card  card:agent:gall
+$  versioned-state
  $%  state-0
  ==
+$  state-0  [%0 =tokens]
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
++  on-poke
  |=  [=mark =vase]
  ^-  (quip card _this)
  ?+  mark  !!
    %leave  :_  this  ~[[%pass /bite-wire %agent [our.bowl %lure] %leave ~]]
    %watch  :_  this  ~[[%pass /bite-wire %agent [our.bowl %lure] %watch /bites]]
    ::
      %token
    =+  !<([token=cord =flag:groups] vase)
    `this(tokens (~(put by tokens) token flag))
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
    =/  =invite:groups  [(~(got by tokens) token.bait) ship.bait]
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
++  on-init   `this
++  on-save   !>(state)
++  on-load   |=(old=vase `this(state !<(_state old)))
++  on-arvo   on-arvo:def
++  on-peek   on-peek:def
--
