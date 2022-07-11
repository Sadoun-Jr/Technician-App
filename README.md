# Technicians

Find various technicians to get the job done<br />
<br />
I will add various info down as I think of it<br />

## ChangeLog

- When user logs in now, his data is immediately retrieved from DB and put in SP, this is for personal details page
- Added visible indicator when user creating account 
- Added onboarding introduction screen

[comment]: <> (## &#40;  &#41; Creating and Styling the layouts)

[comment]: <> (✓ - placeholder layout completed<br />)

[comment]: <> (✓✓ - Layout styled<br />)

[comment]: <> (&#40;  &#41; Welcome layout<br />)

[comment]: <> (   &#40;  &#41; Onboarding layout<br />)

[comment]: <> (   &#40; ✓ &#41; Select register/login layout<br />)

[comment]: <> (&#40;   &#41; Onboarding layout &#40;Explanation of App&#41;<br />)

[comment]: <> (&#40; ✓ &#41; Login and register layout<br />)

[comment]: <> (&#40; ✓ &#41; Step 1: Choose priority &#40;appointment/emergency&#41;<br />)

[comment]: <> (&#40; ✓ &#41; Step 2a: Choose category by technician &#40;plumber, carpenter, etc...&#41;<br />)

[comment]: <> (&#40; ✓ &#41; Step 2b: Choose category by appliance &#40;Washer, AC, Drier, etc...&#41;<br />)

[comment]: <> (&#40; ✓ &#41; Step 3: Choose kind of issues &#40;door fix, high temp, etc...&#41;<br />)

[comment]: <> (&#40; ✓ &#41; Step 4: Choose technician layout<br />)

[comment]: <> (&#40; ✓ &#41; Step 5: Choose appointment date from technician profile page<br />)

[comment]: <> (&#40;  &#41; Step 6: Confirm receipt with appointment info<br />)

[comment]: <> (&#40; ✓ &#41; Consumer dashboard<br />)

[comment]: <> (&#40; ✓ &#41; Pending and completed orders list<br />)

[comment]: <> (&#40; ✓ &#41; Navigation drawer<br />)

[comment]: <> (&#40; ✓ &#41; User favourites<br />)

[comment]: <> (&#40; ✓ &#41; Setup initial user details<br />)

[comment]: <> (&#40; ✓ &#41; Standalone technician profile<br />)

[comment]: <> (&#40; ✓ &#41; Technician portfolio with gallery for every single item<br />)

[comment]: <> (&#40; ✓ &#41; Technician reviews<br />)

[comment]: <> (## Creating the logic)

[comment]: <> (&#40; ✓ &#41; Login and register<br />)

[comment]: <> (&#40; ✓ &#41; Login auto redirect to Dashboard<br />)

[comment]: <> (&#40; ✓ &#41; Add issue to database<br />)

[comment]: <> (&#40; ✓ &#41; Added UID to each issue in the database<br />)

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

## Known bugs/issues:

1. Added ability to delete profile pic
2. Added drop down option for age and province
3. Added city and address
4. Styled profile info page
5. KNOWN BUG: city dropdown button error if re-select province, used IgnorePointer for now
6. KNOWN BUG: prefs profile pic link doesn't switch to null when deleting image, look into changing it to ""
7. Deleting the profile picture will completely delete it even if the user doesn't save changes
8. When the user logs in, the profile pic and name aren't retrieved yet and displayed as empty in the dashboard page


[comment]: <> (## New things I learned:)

## TODO:

- Add firebase app-check
- Add google fonts
- Add facebook login
- Add payment
- Add user details like location etc when creating acc.
- Add zoom drawer package

[comment]: <> (Visit Facebook Developer Account and click on the app you have created, )

[comment]: <> (and at the top of the dashboard change it to Live App.)

[comment]: <> (facebook data deletion link is a problem, try to fix it later)
