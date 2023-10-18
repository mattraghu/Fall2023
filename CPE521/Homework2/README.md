# Homework 2

Consider an omnidirectional robot with a ring of eight 70 KHz sonar sensors that are
fired sequentially. Your robot is capable of accelerating and decelerating at 50 cm/s^2.
It is moving in a world filled with sonar-detectable fixed (nonmoving) obstacles that can
only be detected at 5 meters and closer. Given the bandwidth of your sonar sensors, com-
pute your robot's appropriate maximum speed to ensure no collisions.

## Solution

We know that given a speed $v_max$ and a deceleration $a$, the distance traveled is given by the following equation:

$$d_{deacceleration} = \frac{v_{max}^2}{2a}$$

We also know that the distance traveled by the robot going at a constant speed $v_{max}$ is given by the following equation:

$$d_{constant} = v_{max}t$$

$t$ is the time it takes for the robot to recieve the last sonar reading.

For an object 5 meters away, and 8 sensors we can calculate how often the sensors should be firing with:

$$
d = ct \\
c = 343 m/s \\
d = 5 m \\
t = \frac{d}{c} = \frac{5}{343} = 0.0146 s
$$

To ensure no overlap this time should be multiplied by 8

$$
t_{total} = 8t = 0.1168 s
$$

Now the doppler effect will cause the robot to recieve a higher frequency when moving towards the object and a lower frequency when moving away from the object. The doppler effect is given by the following equation:

$$
f_r = f_t \frac{1}{1 + \frac{v}{c}}
$$

Acceleration of the robot in meters per second squared is given by:

50 cm/s^2 = 0.5 m/s^2
