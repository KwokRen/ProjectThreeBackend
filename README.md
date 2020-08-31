# **DeveloperToob**

## [Frontend](https://github.com/KwokRen/ProjectThreeFrontend/blob/master/README.md)

### Project Snapshots

***

<details class="cursor">
<summary>Desktop View</summary>
<img src="https://res.cloudinary.com/dpggcudix/image/upload/v1598748671/Screen_Shot_2020-08-29_at_8.43.01_PM.png_20-49-28-430_hoyxmy.png" width="400" height= "150">
<img src="https://res.cloudinary.com/dpggcudix/image/upload/v1598748671/Screen_Shot_2020-08-29_at_8.43.35_PM.png_20-49-31-670_qbdnzm.png" width="400" height= "150">
<img src="https://res.cloudinary.com/dpggcudix/image/upload/v1598748671/Screen_Shot_2020-08-29_at_8.45.13_PM.png_20-49-35-575_safobt.png" width="400" height= "150">
</details>
<details class="cursor">
<summary>Mobile View</summary>
<img src="https://res.cloudinary.com/dpggcudix/image/upload/v1598748671/Screen_Shot_2020-08-29_at_8.46.01_PM.png_20-49-38-775_hxojlh.png" width="200" height= "320">
<img src="https://res.cloudinary.com/dpggcudix/image/upload/v1598748671/Screen_Shot_2020-08-29_at_8.46.19_PM.png_20-49-41-642_fz764y.png" width="200" height= "320">
</details>

### Website

***

<a href="https://developertoob.netlify.app/">
DeveloperToob
</a>

<br>
<br>

### Description

***

Deciding you want to be pursue a career in software engineer? Not sure where to start? DeveloperToob is the perfect place for you to begin your journey! DeveloperToob is a free web application that allows users to watch Youtube videos specifically geared towards programming and web development.

Users can browse through the videos freely, or they can choose to register an account on our website. All users can then select videos of their choices and then it will open up a video player. The video player will include the title, a like and dislike feature, and the comments section. Free users can view comments and watch the video, but registered users will have access to adding comments, and using the like and dislike feature. This application is also mobile friendly!

The backend is made with Ruby on Rails, and PostgreSQL. It is deployed through Heroku. 

### Technologies

***

<img src ="https://cdn.worldvectorlogo.com/logos/rails-1.svg" width="100" height="50">
<img src ="https://cdn.worldvectorlogo.com/logos/ruby.svg" width="50" height="50">
<img src ="https://cdn.worldvectorlogo.com/logos/postgresql.svg" width="70" height="50">
<img src ="https://cdn.worldvectorlogo.com/logos/heroku.svg" width="50" height="50">

### Features

***

- Users can view and play videos that are on screen
- Users can view active conversations about a video
- Users can register
- Users can login
- Logged in users can comment on video conversations as well as deleting or updating comments they have created
- Logged in users can like or dislike a video
- Accessible over all media devices

### Future Implementation

***

- Refactoring code
- Fixing Bugs
- Search Functionality
- User's Personal Dashboard
- Favorites
- Watch Later
- Cleaner UX/UI Design
- Pagination
- Categories
- Login will take you back to your previous page
- Replying to comments
- Uploading Videos

# The Backend

### User Controller

***

Our User Controller consists of creating the user, logging in, and verifying whether they logged in or not. The create allows users to create a user, and they will recieve a unique token for their account. The login is how users log in, making sure the token is equivalent to the username and password it matches with. 

### Video Controller

***

The Video Controller consists of showing all videos, showing one and updating the videos. Showing all videos is important because we need to make sure they display on the homepage. That's when we grab all the videos. We grab one video when we users click on one of the video cards. We target one specific video this way. Updating the video is used to update the likes and dislikes. 

### Like Controller

***

The Like Controller consists of showing one likes and dislikes for one specific video. We also had a route that grabbed informtion on whether user voted or not, so we can determine later on if they can create/update. Creating a like/dislike is determined whether the user has liked it or not. If they did, then they cannot like or dislike again because they can only like and dislike on a video once. If they did not have a entry already, then they create one. Updating was tricky, because we had to make sure that there was one and that the one they were updating were based on whether they want to like the same one (therefore removing the data) or whether they want to do the opposite (dislike for like, or vice versa).

### Comment Controller

***

The Comment Controller allowed us to display all, create, update and delete. Displaying all allowed us to display all the comments pertaining to one specific video. Creating allows users to create a new comment and that comment would store the video ID and the user ID of the video and user. For updating, we made sure the user that made the comment is the same as the user that wants to update it, or else they wouldn't be able to update. The same goes for the destroy function, so it would only be accessible if you had account access.