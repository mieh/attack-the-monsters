# attack-the-monsters
simple implementation of OOP

## Phase 1
* Create an instance of monster which has
Hit points: 30,
Monster name: ,
Monster type: {look at point no 2},
Monster Attack: 3,
Monster Defense: 0
There are many kind of monster:

| Name  |  Desc | Perks |
|---|---|---|
|  Animal Monster |  Corrupted animals turned into monster, retaining their body but also has more dangerous claws and fangs | Attack +1 |
| Humanoid Monster | Monster with high intelligence, can use weapons, stronger and more buff than humans | Hit points +10%, Attack +1, Defense +1|
| Golems | Ancient constructs very durable | Hit points +20%, Defense +2|

* Create an instance of player which has
Hit points: 20,
Name: ,
Attack: 5,
Defense: 1,
weapon used: {look at point no 4}

* There are many weapons:

| Name | Perks |
|---|---|
|Sword| Attack +2, Defense +2|
|Axe| Attack +4, Defense -1|
|Knife| Attack +1, Critical strike (which deals 2x more damage but with only 30% occurrences)|

* Monster name are filled by preconfigured names
* Player can fill in their name, and choose any weapon
* Monster type modify their base attributes based on their perks
* Humanoid monster can use weapons (randomize when spawn, either it can use sword, axe, knife, or none)
* Weapons modify base attributes the one who use it based on their perks
