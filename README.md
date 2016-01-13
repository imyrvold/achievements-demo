# achievements-demo
The demo app Achievements uses interactive notifications to interact with the user.
Both UIView animation and Facebook POP animations is demonstrated in the demo.

When the app launches, a short demo description tells the user what to do.
When the user quits the demo, an interactive notification pops up, 
and the user have to drag on the top handle to reveal two buttons.
![ssh1](https://cloud.githubusercontent.com/assets/3294527/12290163/7d22dc16-b9e0-11e5-9e2e-e12af9988535.png)

If the user chooses to make an achievement goal for today, he will click
on the goal button, and this launches the app again to give him a chance to type a goal.
The text slowly fades in using UIView animation.
![ssh2](https://cloud.githubusercontent.com/assets/3294527/12290165/7d281082-b9e0-11e5-9f11-6135f45ee04e.png)

When he quits again, the second notification pops up, and he will have a chance to give 
todays goal result.
The buttons slowly fades in using Facebook POP animation.
![ssh3](https://cloud.githubusercontent.com/assets/3294527/12290164/7d24fd70-b9e0-11e5-9333-42308fbbe346.png)

When the user clicks the YES button, the green circle grows from nothing to reveal the text and Thanks button, 
also using Facebook POP animation.
When the user clicks the Thanks button, the green circle shrinks to nothing, and the Yes button slides down to the button, all using Facebook POP animations.
![ssh4](https://cloud.githubusercontent.com/assets/3294527/12290162/7d2035f6-b9e0-11e5-88c2-1f84571706d6.png)
