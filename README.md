# Technicians

Find various technicians to get the job done<br />
<br />
I will add various info down as I think of it<br />

## ChangeLog

- Added create portfolio page
- Added portfolio collection to firestore
- Added ability to enlarge image to fit screen when clicked
- Replaced listview that shows the images selected with a gridview
- Added ability to long press delete image after being received in the app

## (  ) Creating and Styling the layouts

✓ - placeholder layout completed<br />
✓✓ - Layout styled<br />

(  ) Welcome layout<br />
   (  ) Onboarding layout<br />
   ( ✓ ) Select register/login layout<br />
(   ) Onboarding layout (Explanation of App)<br />
( ✓ ) Login and register layout<br />
( ✓ ) Step 1: Choose priority (appointment/emergency)<br />
( ✓ ) Step 2a: Choose category by technician (plumber, carpenter, etc...)<br />
( ✓ ) Step 2b: Choose category by appliance (Washer, AC, Drier, etc...)<br />
( ✓ ) Step 3: Choose kind of issues (door fix, high temp, etc...)<br />
( ✓ ) Step 4: Choose technician layout<br />
( ✓ ) Step 5: Choose appointment date from technician profile page<br />
(  ) Step 6: Confirm receipt with appointment info<br />
( ✓ ) Consumer dashboard<br />
( ✓ ) Pending and completed orders list<br />
( ✓ ) Navigation drawer<br />
( ✓ ) Technician reviews<br />

## Creating the logic

( ✓ ) Login and register<br />
( ✓ ) Login auto redirect to Dashboard<br />
( ✓ ) Add issue to database<br />
( ✓ ) Added UID to each issue in the database<br />

[comment]: <> (## Features to implement:)

[comment]: <> (1. Ability for technician to choose if they can serve emergencies or not<br />)

[comment]: <> (2. Technician setup profile will include<br />)

[comment]: <> (   a. Selecting category<br />)

[comment]: <> (   b. Selecting availability for emergencies<br />)

[comment]: <> (   c. Selecting charge rate<br />)

[comment]: <> (   d. How much time average per job<br />)

[comment]: <> (   e. Contact info<br />)

[comment]: <> (3. Auto-booking system for technician to prevent conflicts<br />)

[comment]: <> (4. Confirm identity of technician using national ID<br />)

[comment]: <> (5. Online and physical payment available<br />)

[comment]: <> (6. Technician profile page will contain previous work photos and reviews,this is the )

[comment]: <> (same page that the consumer will be able to book an appointment from.<br />)

[comment]: <> (7. NO CHAT SYSTEM<br />)

## Known bugs:

1. The bottom navigator from the "github.com/Pyozer/introduction_screen" lib moves slightly up in
position when the next button is revealed for the first time, it is very minimal though and can be
solved by making the button transparent and not clickable
2. The picture of the issue isn't aligned properly in the orders page
3. Pressing back button after navigating from drawer returns you to prev screen with drawer open, 
need to close it.

[comment]: <> (## New things I learned:)

## TODO:

- Add firebase app-check
- Add google fonts
