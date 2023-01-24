/-  lure
/+  default-agent, verb, dbug
::
=|  state=~
%-  agent:dbug
%+  verb  &
^-  agent:gall
|_  =bowl:gall
+*  this  .
    def   ~(. (default-agent this %|) bowl)
::
++  on-poke
  |=  [=mark =vase]
  :_  this
  ?+  mark  !!
    %leave  [%pass /bite-wire %agent [our.bowl %lure] %leave ~]~
    %watch  [%pass /bite-wire %agent [our.bowl %lure] %watch /bites]~
  ==
::
++  on-watch
  |=  =path
  (on-watch:def +<)
::
++  on-agent
  |=  [=wire =sign:agent:gall]
  ^-  (quip card:agent:gall _this)
  ?+    -.sign  !!
      %watch-ack  `this
      %kick       `this
      %fact
    =+  !<(=bait:lure q.cage.sign)
    ~&  [%sub-got bait]
    :_  this  :_  ~
    =/  msg  (cat 3 'welcome, your token was ' token.bait)
    [%pass /hi %agent [ship.bait %hood] %poke %helm-hi !>(msg)]
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
