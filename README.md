# banner_widget
------
A new Flutter  BannerWidget project 


------

## How to Use
```python
# add this line to your dependencies
count_down_timer: ^0.0.1
```


```python
 BannerWidget(data,
                duration: 2000,
                height: 200.0,
                selectedColor: Colors.red,
                unSelectedColor: Colors.white,
                onBannerItemClick: (int position, BannerItem item) {
                  Fluttertoast.showToast(
                      msg: 'index=$position banner is clicked！',
                      toastLength: Toast.LENGTH_LONG);
                },
                build: null,
                descriptionBackgroundColor: const Color(0x33000000),
                textInfoDirect: InfoDirect.HORIZONTAL,
                circleRadius: 5.0,
                indicatorStyle: IndicatorStyle.ELLIPTICAL,
                ellipticalWidth: 16.0,
                ellipticalHeight: 8.0,
                cornerRadius: 10.0),
```
### API

| property        | description    | defaultValue
| :--------   | :-----  |:--------
| duration     | int    | 2000
| height        | double | 200.0
| selectedColor        |Color | Colors.red |
| unSelectedColor        | Color | Colors.white |
| onBannerItemClick        | OnBannerItemClick(int position, BannerItem bannerItem)   | null
| build        | CustomBuild(int position, BannerItem item) | null
|descriptionBackgroundColor   | Color | const Color(0x33000000)
|textInfoDirect   | InfoDirect |  InfoDirect.HORIZONTAL
|circleRadius   | double | 5.0
|indicatorStyle   | IndicatorStyle | IndicatorStyle.ELLIPTICAL
|ellipticalWidth   | double | 16.0
|ellipticalHeight   | double | 8.0
|cornerRadius   | double | 10.0




###  [GitHub](https://github.com/manburenshenglu/banner_widget)