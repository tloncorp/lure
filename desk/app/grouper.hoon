/-  reel, groups
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
  ~[[%pass /bite-wire %agent [our.bowl %reel] %watch /bites]]
++  on-poke
  |=  [=mark =vase]
  ^-  (quip card _this)
  ?+  mark  !!
    %leave  :_  this  ~[[%pass /bite-wire %agent [our.bowl %reel] %leave ~]]
    %watch  :_  this  ~[[%pass /bite-wire %agent [our.bowl %reel] %watch /bites]]
    ::
      %grouper-enable
    =+  !<(name=cord vase)
    `this(enabled-groups (~(put in enabled-groups) name))
      %grouper-disable
    =+  !<(name=cord vase)
    `this(enabled-groups (~(del in enabled-groups) name))
      %grouper-ask-enabled
    =+  !<(name=cord vase)
    =/  enabled  (~(has in enabled-groups) name)
    :_  this
    ~[[%pass /ask %agent [src.bowl %grouper] %poke %grouper-answer-enabled !>([our.bowl name enabled])]]
      %grouper-answer-enabled
    =/  [host=ship name=cord enabled=?]  !<([ship cord ?] vase)
    :_  this
    ~[[%give %fact ~[[%group-enabled (scot %p host) name ~]] %json !>(b+enabled)]]
  ==
::
++  on-watch
  |=  =path
  ^-  (quip card _this)
  ?>  =(our.bowl src.bowl)
  ?+  path  (on-watch:def path)
      [%group-enabled @ @ ~]
    :_  this
    ~[[%pass path %agent [(need (slaw %p i.t.path)) %grouper] %poke %grouper-ask-enabled !>(i.t.t.path)]]
  ==
::
++  on-agent
  |=  [=wire =sign:agent:gall]
  ^-  (quip card _this)
  ?+    -.sign  !!
      %watch-ack  `this
      %kick       `this
      %fact
    =+  !<(=bite:reel q.cage.sign)
    ?>  (~(has in enabled-groups) token.bite)
    =/  =invite:groups  [[our.bowl token.bite] ship.bite]
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
++  on-peek
  |=  =path
  ^-  (unit (unit cage))
  ?+  path  [~ ~]
      [%x %enabled @ ~]
    ``json+!>([%b (~(has in enabled-groups) i.t.t.path)])
  ==
::
--
