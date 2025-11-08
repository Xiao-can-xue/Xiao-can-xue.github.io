<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>冬日神秘礼物 完美交互弹窗</title>
    <style>
        /* 弹窗弹入动画 */
        @keyframes popupIn {
            0% {
                opacity: 0;
                transform: scale(0.8) translate(-50%, -70%);
            }
            100% {
                opacity: 1;
                transform: scale(1) translate(-50%, -50%);
            }
        }
        .popup {
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.15);
            padding: 30px;
            width: 80%;
            max-width: 500px;
            z-index: 9999;
            text-align: center;
            animation: popupIn 0.4s cubic-bezier(0.25, 0.8, 0.25, 1) forwards;
            opacity: 0;
        }
        .popup-header {
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 25px;
            font-size: 28px;
            font-weight: bold;
        }
        .popup-header svg {
            margin-right: 12px;
            width: 36px;
            height: 36px;
        }
        .popup-content {
            font-size: 20px;
            margin-bottom: 30px;
            line-height: 1.6;
        }
        .popup-btn {
            background-color: #2188ff;
            color: #fff;
            border: none;
            border-radius: 6px;
            padding: 14px 35px;
            font-size: 18px;
            font-weight: 600;
            cursor: pointer;
            border: 2px solid #ffb74d;
            transition: all 0.2s ease;
            display: inline-block; /* 确保按钮可点击 */
        }
        .popup-btn:hover {
            background-color: #1e82e5;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        .mask {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            z-index: 9998;
        }
        /* 卡片样式保持不变 */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            background-color: #f5f5f5;
            font-family: "Microsoft YaHei", sans-serif;
            overflow: hidden;
        }
        .card {
            position: absolute;
            padding: 15px 20px;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.12);
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            gap: 6px;
            cursor: pointer;
            width: 133px; /* 3.5cm固定宽度 */
            height: auto;
            animation: bounceIn 0.15s cubic-bezier(0.175, 0.885, 0.32, 1.275) forwards;
            opacity: 0;
            transform: translateY(15px) scale(0.97);
            color: #333;
            display: none; /* 初始隐藏卡片 */
        }
        .card:hover {
            transform: scale(1.02);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.18);
            transition: transform 0.08s ease, box-shadow 0.08s ease;
        }
        .card .hint {
            display: flex;
            align-items: center;
            font-weight: 600;
            font-size: 13px;
        }
        .card .hint svg {
            width: 16px;
            height: 16px;
            margin-right: 4px;
            fill: currentColor;
        }
        .card .text {
            font-size: 14px;
            font-weight: 500;
            text-align: center;
            white-space: nowrap;
        }
        @keyframes bounceIn {
            0% {
                opacity: 0;
                transform: translateY(15px) scale(0.97);
            }
            90% {
                opacity: 1;
                transform: translateY(-2px) scale(1.01);
            }
            100% {
                opacity: 1;
                transform: translateY(0) scale(1);
            }
        }
    </style>
</head>
<body>
    <!-- 弹窗HTML结构 -->
    <div class="mask" id="mask"></div>
    <div class="popup" id="popup">
        <div class="popup-header">
            <svg viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                <path d="M12 2C6.48 2 2 6.48 2 12C2 17.52 6.48 22 12 22C17.52 22 22 17.52 22 12C22 6.48 17.52 2 12 2ZM12 20C7.59 20 4 16.41 4 12C4 7.59 7.59 4 12 4C16.41 4 20 7.59 20 12C20 16.41 16.41 20 12 20ZM11 16.5L12 15.5L13 16.5V18H11V16.5ZM11 13.5L12 12.5L13 13.5V15H11V13.5Z" fill="#6ab7f5"/>
            </svg>
            神秘礼物
        </div>
        <div class="popup-content">冬天的第一份礼物，确定要打开吗？</div>
        <button class="popup-btn" id="confirmBtn">确定</button>
    </div>

    <script>
        // 确保按钮可点击的终极方案：直接在HTML加载后立即绑定
        window.onload = function() {
            const confirmBtn = document.getElementById('confirmBtn');
            const mask = document.getElementById('mask');
            const popup = document.getElementById('popup');

            confirmBtn.addEventListener('click', function() {
                mask.style.display = 'none';
                popup.style.display = 'none';
                
                // 以下是原卡片生成逻辑（保持不变）
                const careTexts = [
                    "记得按时吃饭哦", "天冷了多穿件衣服", "多喝水对身体好", "工作再忙也要休息", "早点睡觉别熬夜",
                    "保持好心情很重要", "累了就给自己放假", "记得吃水果补维C", "多运动增强免疫力", "每天都要开开心心",
                    "别给自己太大压力", "胃不舒服喝温粥", "出门记得带伞呀", "看屏幕久了要远眺", "偶尔放松一下呀",
                    "多和朋友聊聊天", "睡前别刷手机啦", "注意保暖别着凉", "喜欢就去买呀", "今天也要元气满满",
                    "少吃生冷护肠胃", "别忘涂防晒霜呀", "压力大就听听歌", "走路注意安全呀", "记得吃早餐呀",
                    "保持微笑呀", "别憋尿对肾不好", "周末出去散散心", "要好好爱自己呀", "一切都会变好的",
                    "下雨路滑慢一点", "多喝温水润喉咙", "别太劳累啦", "开心最重要呀", "记得给家人报平安",
                    "学习工作循序渐进", "偶尔吃点甜食呀", "保持规律作息", "对自己好一点呀", "别忘吃午饭呀",
                    "天热注意防暑呀", "记得补充水分", "别熬夜伤身体", "有空多休息呀", "保持乐观心态",
                    "和喜欢的人多联系", "做自己喜欢的事", "别勉强自己呀", "好好照顾自己", "平安健康最重要"
                ];
                let usedIndexes = [];
                let zIndexCounter = 1;

                function getRandomColor() {
                    const colors = [
                        '#fff0f6', '#f0f9ff', '#f9f0ff', '#f0fff4', '#fff7e6',
                        '#e6f7ff', '#fdf2f8', '#f5fafe', '#fcf1f7', '#f8f8f8',
                        '#e8f4f8', '#faf0f5', '#f2f9f2', '#fff3cd', '#e0f7fa',
                        '#f5f5f5', '#ffe4e1', '#f0f8fb', '#fef7fb', '#eaf6fa'
                    ];
                    return colors[Math.floor(Math.random() * colors.length)];
                }

                function createSingleCard(delay) {
                    if (usedIndexes.length === careTexts.length) {
                        usedInd
