1. Vi kan tilføge en ny bruger til systemet, f.eks. Bob med bruger id 1:

```sh
BOB=1;
scripts/add-subject.sh $BOB;
```

2. Bob kan også have en EHR i systemet:

```sh
scripts/add-object.sh EHR Bob-blodprøve;
```

3. For at markere at den EHR omhandler Bob, giver vi ham en "owner" relation:

```sh
scripts/add-relation.sh $BOB owner EHR Bob-blodprøve;
```

4. "owner" er defineret i schemas/EHR.tc typeconfig:

```sh
nvim schemas/EHR.tc;
```

5. Vi kan se at han nu burde have "redact" og "view" permissions:

```sh
scripts/query-permission.sh $BOB EHR Bob-blodprøve redact;
scripts/query-permission.sh $BOB EHR Bob-blodprøve view;
```

6. Vi har også defineret en object type: "group":

```sh
scripts/add-object.sh group læge;
scripts/add-object.sh group overlæge;
```

7. Vi kan lave en relation som siger at alle medlemmer af `doctor` er editor af `Bob-blodprøve`:

```sh
scripts/add-relation-userset.sh member group læge editor EHR Bob-blodprøve;
```

8. Vi kan nu lave en doctor, og gøre dem medlem af denne gruppe:

```sh
MARTIN=2;
scripts/add-subject.sh $MARTIN;
scripts/add-relation.sh $MARTIN member group læge;
```

9. Vi kan nu se at Martin har edit permission på Bob-blodprøve,
   selvom at han ikke har en direkte relation til den:

```sh
scripts/query-permission.sh $MARTIN EHR Bob-blodprøve edit;
```

10. Vi kan også oprætte en overlæge, og markere overlæge gruppen som en "parent" af læge gruppen:

```sh
ALICE=3;
scripts/add-subject.sh $ALICE; #Opræt alice bruge
scripts/add-relation.sh $ALICE member group overlæge; # Gør alice en overlæge
scripts/add-relation-userset.sh ... group overlæge parent group læge # Lav object to object "parent" relation
```

11. Vi kan kigge på schemas/group.tc typeconfig og se hvad det gør:

```sh
nvim schemas/group.tc;
```

12. Hun er automatisk er bleven `member` af `group:læge`:

```sh
scripts/query-permission.sh $ALICE group læge view_members; # Er member af group:læge
```

13. Alice automatisk også editor på Bob-blodprøve:

```sh
scripts/query-permission.sh $ALICE EHR Bob-blodprøve edit; # Kan redigere bob EHR
```
