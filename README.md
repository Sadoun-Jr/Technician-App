# Technicians

Find various technicians to get the job done<br />
<br />
I will add various info down as I think of it<br />

## ChangeLog

- Changed the toggle of category/technician to global header and changed its
visibility accordingly<br />
- Added list of issues for various technicians

## (  ) Creating and Styling the layouts

✓ - placeholder layout completed<br />
✓✓ - Layout styled<br />

(  ) Welcome layout<br />
   (  ) Onboarding layout<br />
   ( ✓ ) Select register/login layout<br />
(   ) Onboarding layout (Explanation of App)<br />
( ✓ ) Login and register layout<br />

Consumer:<br />
( ✓ ) Step 1: Choose priority (appointment/emergency)<br />
( ✓ ) Step 2a: Choose category by technician (plumber, carpenter, etc...)<br />
( ✓ ) Step 2b: Choose category by appliance (Washer, AC, Drier, etc...)<br />
( ✓ ) Step 3: Choose kind of issues (door fix, high temp, etc...)<br />
(  ) Step 4: Choose technician layout<br />
(  ) Step 5: Choose appointment date<br />
(  ) Step 6: Confirm receipt with appointment info<br />
(  ) Consumer dashboard<br />

Technician:<br />
(  ) Setup profile layout<br />
(  ) Profile page layout<br />
(  ) Upload previous works layout<br />
(  ) Technician dashboard<br />

## Creating the logic


## Features to implement:

1. Ability for technician to choose if they can serve emergencies or not<br />

2. Technician setup profile will include<br />
   a. Selecting category<br />
   b. Selecting availability for emergencies<br />
   c. Selecting charge rate<br />
   d. How much time average per job<br />
   e. Contact info<br />

3. Auto-booking system for technician to prevent conflicts<br />

4. Confirm identity of technician using national ID<br />

5. Online and physical payment available<br />

6. Technician profile page will contain previous work photos and reviews,this is the 
same page that the consumer will be able to book an appointment from.<br />

7. NO CHAT SYSTEM<br />

## Known bugs:

1. The bottom navigator from the "github.com/Pyozer/introduction_screen" lib moves slightly up in
position when the next button is revealed for the first time, it is very minimal though and can be
solved by making the button transparent and not clickable

2. When switching between onboarding pages, the variables for selection remain the same which means
that for example, if user selects plumber issue #3 but then goes back and chooses a carpenter instead
the carpenter issue #3 will be highlighted



