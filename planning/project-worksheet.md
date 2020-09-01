# Project Overview

## Project Description

For Project Three of the General Assembly SEI course, we were assigned to create a website that shows our knowledge and understanding of CRUD and RESTful APIs. We have to create the backend using Ruby on Rails. We create our frontend using HTML, CSS, and JavaScript.

For this project, we will be building a video hosting website (using Youtube API) and host videos pertaining specifically to web developers. Using Ruby on Rails, we create different models to represent how users can input their data. Afterwards, we worked on controllers that will allow users to create, read, update, and delete (CRUD) comments on the website. Finally, we need to put them in the routes so the backend and the frontend can communicate with one another.

## User Stories

- Users see a grid of videos on homepage
- Users can click on one video to watch it on the video player
- Users can create their own accounts
- Users can log in and comment on each video
- Users can edit comments or delete them
- Users can navigate using the navigation bar
- Users can like and dislike videos

## Project Schedule

|  Day | Deliverable | Status
|---|---| ---|
|Saturday, August 22nd (Day 1)| Project Description / Wireframes / Priority Matrix / Timeline `backend` & `frontend` | Complete
|Sunday, August 23nd (Day 2)| Building out the `frontend` frame | Complete
|Monday, August 24th (Day 3)| Working on `backend`| Complete
|Tuesday, August 25th (Day 4)| Finishing up `backend` & fetching to `frontend` | Complete
|Wednesday, August 26th (Day 5)| Fixing breakcases | Complete
|Thursday, August 27th (Day 6)| Bug Fixes & Deployment | Complete
|Friday, August 28th (Day 7)| Post-MVP & CSS in the `frontend`| Complete
|Saturday, August 29th (Day 8)| Seeding videos in our database & more CSS| Complete
|Sunday, August 30th (Day 9)| Finish Documentation | Complete
|Monday, August 31st (Day 10)| Presentations | Complete


## Wireframes


- [Mobile](https://res.cloudinary.com/dpggcudix/image/upload/v1598051059/Screen_Shot_2020-08-21_at_7.03.51_PM_y3anyn.png)
- [Desktop](https://res.cloudinary.com/dpggcudix/image/upload/v1598051059/Screen_Shot_2020-08-21_at_7.03.36_PM_mjwsgq.png)

## Time / Priority Matrix 

- [Time / Priority Matrix](https://res.cloudinary.com/dpggcudix/image/upload/v1598046174/Screen_Shot_2020-08-21_at_5.42.34_PM_z3asuy.png)

## MVP / PostMVP

### MVP 

:heavy_check_mark: Build and Test Authentication (JWT) <br>
:heavy_check_mark: Build User Model <br>
:heavy_check_mark: Build Video Model <br>
:heavy_check_mark: Build Comments Model <br>
:heavy_check_mark: Build Like Model <br>
:heavy_check_mark: Test Models with Authentication <br>
:heavy_check_mark: Testing on Postman <br>
:heavy_check_mark: Deploy and Test Deployed API <br>
:heavy_check_mark: Importing all the dependencies on our Gemfile <br>
:heavy_check_mark: Create the controllers <br>
:heavy_check_mark: Create the routes <br>

### PostMVP 

:construction: Search functionality <br>
:construction: Categorizing videos <br>
:heavy_check_mark: Fixing errors <br>
:heavy_check_mark: Refactoring <br>

## Functional Components

### MVP
| Component | Priority | Estimated Time | Time Invested | Actual Time |
| --- | :---: |  :---: | :---: | :---: |
| Importing Dependencies | L | 0hr | 0hr | 0hr|
| Create Models | H | 3hr | 1hr | 1hr|
| Creating Seed | L | 3hr | 1hr | 1hr|
| Youtube API | H | 3hr | 6hr | 6hr|
| Creating Controllers | H | 6hr| 10hr | 10hr |
| Creating Routes | M | 1hr | 1hr | 1hr|
| Testing Routes | H | 3hrs| 1hr | 1hr |
| Deployment and Testing on Deployed Website | H | 2hr | 1hr | 1hr|
| Authentication | H | 2hr | 1hr | 1hr|
| Total | H | 19hrs| 22hrs | 22hrs |

### PostMVP
| Component | Priority | Estimated Time | Time Invested | Actual Time |
| --- | :---: |  :---: | :---: | :---: |
| Search Functionality | L | 2hr | 0hr | 0hr|
| Categorizing Videos | L | 3.5hr | 0hr | 0hr|
| Total | H | 5.5hrs| 0hrs | 0hrs |

## Additional Libraries
 
 - [Youtube API](https://developers.google.com/youtube/v3)

## Code Snippet

```
  def create
    if !params[:user_id].empty?
      @user_like = Like.where(video_stats_params)[0]
      if !@user_like
        @new_like = Like.create(like_params)
        render :json => {
            :response => "liked/disliked!"
        }
      elsif @user_like[:is_liked] == params[:is_liked]
        @user_like.destroy
        render :json => {
            :response => "Removed record",
            :data => @user_like
        }
      else
        @user_like.update(is_liked:params[:is_liked])
        render :json => {
              :response => "updated is_liked value"
          }
      end
    else
      render :json => {
          :response => "Log in to vote"
      }
    end
  end
```

This was our controller for the create likes route. This route seems long because it has a lot of break cases to solve, which include if the like was already their, and when it is, is it removed from the current one and given to the dislike, vice versa, or just simply removed altogether. 

First we check if the user is logged in or not, because the like and dislike feature is a registered user only feature. Afterwards, we make sure the user has already created a like/dislike or not, and if it does not exist yet, then you create a like or dislike. However, you might have a user that will click on a like or dislike and it already currently exists. We then check or not if the click of like or dislike are the same as what they previously chosen or not. If it is, then we simply remove the row that is stored in our database and subtract the count from the section. If they are not, then we'd have to deduct the value of the current one and the add it to the newly clicked one. We simply do this by updating our isLiked column in our database to match what we clicked. 

## Issues and Resolutions

We were trying to create a like and dislike feature without creating a new model. The problem we ran into was that the video was only updating once, and many users can change it and it wasn't unique. Suresh helped us out by explaining that we needed to create another model to tackle on this situation. What this model was would be the Like model, where it would have references to both the video and the user. The likes created would have to be unique, and only one user can only vote one time on a video, so if there was already an reference to user id 1 AND video id 1, then there can't be another one. This way, users can vote once only per video. We also created a is_liked column, where it will be a boolean value. When it is a liked video, then it is set to true, otherwise if it is a dislike, then we set it to false. We evaluate the counter for likes based on the true and falses of a video. 