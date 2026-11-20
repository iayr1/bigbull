import 'package:flutter/material.dart';

class Quiz {
  final String question;
  final List<String> options;
  final int answer;
  final String explain;
  const Quiz(this.question, this.options, this.answer, this.explain);
}

class Lesson {
  final String title;
  final String duration;
  final List<(String, String)> sections;
  final List<String> keyPoints;
  final Quiz quiz;
  const Lesson(
    this.title,
    this.duration,
    this.sections,
    this.keyPoints,
    this.quiz,
  );
}

class Course {
  final String id;
  final String title;
  final String category;
  final String level;
  final String emoji;
  final Color color;
  final String description;
  final List<Lesson> lessons;
  const Course({
    required this.id,
    required this.title,
    required this.category,
    required this.level,
    required this.emoji,
    required this.color,
    required this.description,
    required this.lessons,
  });

  int get totalMinutes {
    var secs = 0;
    for (final l in lessons) {
      final p = l.duration.split(':');
      secs += int.parse(p[0]) * 60 + int.parse(p[1]);
    }
    return (secs / 60).round();
  }
}

const categories = [
  'All',
  'Basics',
  'Stocks',
  'Trading',
  'F&O',
  'Mutual Funds',
  'Fixed Income',
  'Commodities',
  'Tax',
];

const courses = <Course>[
  // ───────────────────────── 1. BASICS
  Course(
    id: 'basics',
    title: 'Stock Market Basics',
    category: 'Basics',
    level: 'Beginner',
    emoji: '🐂',
    color: Color(0xFFFFD84D),
    description:
        'Start from zero. Learn what the share market is, who runs it, how to open a Demat account and how a buy order actually works.',
    lessons: [
      Lesson(
        'What is the Share Market?',
        '4:10',
        [
          (
            'Owning a piece of a company',
            'A share is a small unit of ownership in a company. When you buy one share of a company, you become a part-owner and share in its profits (through dividends) and growth (through a rising share price).',
          ),
          (
            'Why companies list',
            'Companies sell shares to the public to raise money for expansion without taking loans. Investors get a chance to grow their wealth along with the business.',
          ),
        ],
        [
          'A share = part ownership of a company',
          'Returns come from price rise + dividends',
          'Prices move on demand, supply and expectations',
        ],
        Quiz(
          'What do you own when you buy a share?',
          ['A loan to the company', 'A part of the company', 'A fixed deposit'],
          1,
          'A share represents part ownership (equity) in the company.',
        ),
      ),
      Lesson(
        'NSE, BSE & SEBI',
        '3:45',
        [
          (
            'The exchanges',
            'India has two main stock exchanges: the National Stock Exchange (NSE) and the Bombay Stock Exchange (BSE). They are marketplaces that match buyers and sellers electronically.',
          ),
          (
            'The regulator',
            'SEBI (Securities and Exchange Board of India) regulates the market, protects investors and makes rules for brokers, companies and mutual funds.',
          ),
        ],
        [
          'NSE and BSE are exchanges',
          'SEBI is the market regulator',
          'Brokers connect you to the exchanges',
        ],
        Quiz(
          'Who regulates the Indian stock market?',
          ['RBI', 'SEBI', 'NSE'],
          1,
          'SEBI is the securities market regulator. RBI regulates banks and money supply.',
        ),
      ),
      Lesson(
        'Demat & Trading Account',
        '3:12',
        [
          (
            'Demat account',
            'A Demat (dematerialised) account holds your shares in electronic form, just like a bank account holds money. Depositories CDSL and NSDL maintain these records.',
          ),
          (
            'Trading account',
            'A trading account, opened with a broker, is used to place buy and sell orders. You need both, plus a linked bank account and PAN, to invest.',
          ),
        ],
        [
          'Demat = locker for shares',
          'Trading account = place orders',
          'KYC needs PAN, Aadhaar and bank details',
        ],
        Quiz(
          'Where are your shares stored?',
          ['Trading account', 'Demat account', 'Savings account'],
          1,
          'Shares are held electronically in your Demat account.',
        ),
      ),
      Lesson(
        'Sensex & Nifty',
        '3:30',
        [
          (
            'What is an index?',
            'An index tracks a basket of stocks to show how the overall market is doing. Nifty 50 tracks 50 large companies on NSE; Sensex tracks 30 large companies on BSE.',
          ),
          (
            'Why it matters',
            'When people say "the market is up", they usually mean the Nifty or Sensex went up. Indices are also used as benchmarks to judge a fund or portfolio.',
          ),
        ],
        [
          'Nifty 50 = 50 stocks on NSE',
          'Sensex = 30 stocks on BSE',
          'Indices act as market benchmarks',
        ],
        Quiz(
          'How many stocks are in the Nifty 50?',
          ['30', '50', '100'],
          1,
          'As the name says, Nifty 50 contains 50 stocks.',
        ),
      ),
      Lesson(
        'Order Types',
        '4:40',
        [
          (
            'Market & limit orders',
            'A market order buys or sells immediately at the best available price. A limit order only executes at your chosen price or better.',
          ),
          (
            'Stop-loss orders',
            'A stop-loss order automatically exits a position when price hits a trigger, limiting your loss. It is the most important risk tool for any trader.',
          ),
        ],
        [
          'Market order = speed',
          'Limit order = price control',
          'Stop-loss = protection',
        ],
        Quiz(
          'Which order guarantees your price but not execution?',
          ['Market order', 'Limit order', 'None'],
          1,
          'A limit order fills only at your price or better, so it may not fill at all.',
        ),
      ),
      Lesson(
        'Primary vs Secondary Market',
        '3:05',
        [
          (
            'Primary market',
            'This is where companies issue new shares for the first time, for example through an IPO. Money goes to the company.',
          ),
          (
            'Secondary market',
            'After listing, shares trade between investors on the exchange. Money moves between buyers and sellers, not to the company.',
          ),
        ],
        [
          'IPO happens in the primary market',
          'Daily trading = secondary market',
          'T+1 settlement in India',
        ],
        Quiz(
          'When you buy a listed share from another investor, it is the…',
          ['Primary market', 'Secondary market', 'Debt market'],
          1,
          'Trading between investors after listing is the secondary market.',
        ),
      ),
    ],
  ),

  // ───────────────────────── 2. FUNDAMENTAL
  Course(
    id: 'fundamental',
    title: 'Fundamental Analysis',
    category: 'Stocks',
    level: 'Intermediate',
    emoji: '🔍',
    color: Color(0xFF9BE7C4),
    description:
        'Read a company like an owner. Understand financial statements, key ratios and how to judge whether a stock is fairly valued.',
    lessons: [
      Lesson(
        'Introduction to Fundamentals',
        '3:50',
        [
          (
            'Business first',
            'Fundamental analysis studies the business behind a stock: its products, management, competition and financials, to estimate its true (intrinsic) value.',
          ),
          (
            'Long-term view',
            'Over short periods prices are noisy, but over years they tend to follow earnings growth. That is why long-term investors focus on fundamentals.',
          ),
        ],
        [
          'Study the business, not just the price',
          'Goal: estimate intrinsic value',
          'Best for long-term investing',
        ],
        Quiz(
          'Fundamental analysis mainly studies…',
          [
            'Price charts',
            'The business and its financials',
            'Daily news only',
          ],
          1,
          'It focuses on the company’s business quality and numbers.',
        ),
      ),
      Lesson(
        'Reading the P&L Statement',
        '5:10',
        [
          (
            'Revenue to profit',
            'The Profit & Loss statement shows revenue, expenses and profit for a period. Look at revenue growth, operating margin (EBITDA) and net profit trend over 5+ years.',
          ),
          (
            'Quality of earnings',
            'One-time gains can inflate profit. Check whether profits come from the core business and whether margins are stable.',
          ),
        ],
        [
          'Revenue − expenses = profit',
          'Track growth over multiple years',
          'Watch out for one-off items',
        ],
        Quiz(
          'Which statement shows a company’s profit for a year?',
          ['Balance sheet', 'P&L statement', 'Shareholding pattern'],
          1,
          'The Profit & Loss statement reports income and expenses.',
        ),
      ),
      Lesson(
        'Balance Sheet & Cash Flow',
        '5:30',
        [
          (
            'Balance sheet',
            'It lists what a company owns (assets) and owes (liabilities) at a point in time. High debt relative to equity increases risk.',
          ),
          (
            'Cash flow',
            'Profit is an opinion, cash is a fact. Healthy companies generate positive operating cash flow that roughly matches their profits.',
          ),
        ],
        [
          'Assets = Liabilities + Equity',
          'Low debt = more resilience',
          'Operating cash flow should back profits',
        ],
        Quiz(
          'A company reports profit but negative operating cash flow for years. This is…',
          ['A great sign', 'A warning sign', 'Irrelevant'],
          1,
          'Profits not converting to cash can signal aggressive accounting or weak collections.',
        ),
      ),
      Lesson(
        'Key Ratios: PE, PB, ROE',
        '4:45',
        [
          (
            'Valuation ratios',
            'P/E = Price ÷ Earnings per share. It shows how much you pay for ₹1 of profit. P/B compares price with book value. Compare with peers and history, not in isolation.',
          ),
          (
            'Return ratios',
            'ROE (Return on Equity) and ROCE show how efficiently a company uses capital. Consistent ROE above 15% is often a sign of a quality business.',
          ),
        ],
        [
          'P/E = price ÷ EPS',
          'ROE shows capital efficiency',
          'Always compare with peers',
        ],
        Quiz(
          'A stock trades at ₹200 with EPS of ₹10. What is its P/E?',
          ['10', '20', '2000'],
          1,
          '200 ÷ 10 = 20.',
        ),
      ),
      Lesson(
        'Economic Moat & Management',
        '4:00',
        [
          (
            'Moat',
            'A moat is a lasting competitive advantage – a strong brand, network effects, low cost or high switching costs – that protects profits from competitors.',
          ),
          (
            'Management quality',
            'Check promoter holding, pledging of shares, related-party transactions and capital allocation track record.',
          ),
        ],
        [
          'Moats protect long-term profits',
          'High promoter pledge is a red flag',
          'Good capital allocation compounds value',
        ],
        Quiz(
          'Which is an example of an economic moat?',
          ['A one-time tax refund', 'A powerful brand', 'A rising share price'],
          1,
          'Brands give pricing power that competitors struggle to copy.',
        ),
      ),
      Lesson(
        'Intro to Valuation (DCF)',
        '6:20',
        [
          (
            'Discounted Cash Flow',
            'DCF estimates the value of a business by projecting future free cash flows and discounting them back to today. Small changes in assumptions change the answer a lot.',
          ),
          (
            'Margin of safety',
            'Since valuation is uncertain, investors buy only when the price is well below their estimated value, leaving a margin of safety.',
          ),
        ],
        [
          'Value = present value of future cash',
          'Assumptions drive the result',
          'Use a margin of safety',
        ],
        Quiz(
          'Why use a margin of safety?',
          [
            'To buy faster',
            'Because valuations are uncertain',
            'To avoid taxes',
          ],
          1,
          'It protects you if your estimates turn out too optimistic.',
        ),
      ),
    ],
  ),

  // ───────────────────────── 3. TECHNICAL
  Course(
    id: 'technical',
    title: 'Technical Analysis',
    category: 'Trading',
    level: 'Intermediate',
    emoji: '📈',
    color: Color(0xFFB9A7FF),
    description:
        'Learn to read price charts: candlesticks, trends, support & resistance, chart patterns and popular indicators like RSI and MACD.',
    lessons: [
      Lesson(
        'Introduction to Charts',
        '3:20',
        [
          (
            'Price tells a story',
            'Technical analysis studies price and volume history to spot trends and probable future moves. It assumes price reflects all known information.',
          ),
          (
            'Timeframes',
            'The same stock can look different on a 5-minute, daily or weekly chart. Traders pick timeframes that match their holding period.',
          ),
        ],
        [
          'Charts show supply and demand',
          'Trends tend to persist',
          'Pick timeframe by trading style',
        ],
        Quiz(
          'Technical analysis mainly uses…',
          ['Balance sheets', 'Price & volume data', 'Annual reports'],
          1,
          'It focuses on price action and volume.',
        ),
      ),
      Lesson(
        'Candlestick Patterns',
        '5:40',
        [
          (
            'Anatomy of a candle',
            'Each candle shows Open, High, Low and Close. A green candle closes above its open, a red candle closes below. Wicks show rejected prices.',
          ),
          (
            'Common patterns',
            'Doji (indecision), Hammer (possible bottom), Shooting Star (possible top) and Engulfing patterns (reversal) are the most widely watched.',
          ),
        ],
        [
          'Candle = OHLC in one bar',
          'Long wicks = rejection',
          'Patterns need confirmation',
        ],
        Quiz(
          'A Hammer after a downtrend usually suggests…',
          ['Possible reversal up', 'Strong continuation down', 'Nothing'],
          0,
          'A hammer shows buyers rejected lower prices, a possible bullish reversal.',
        ),
      ),
      Lesson(
        'Support & Resistance',
        '4:30',
        [
          (
            'Floors and ceilings',
            'Support is a price zone where buying tends to appear; resistance is where selling tends to appear. They form because traders remember past prices.',
          ),
          (
            'Role reversal',
            'When resistance breaks, it often becomes new support, and vice versa.',
          ),
        ],
        [
          'Support = demand zone',
          'Resistance = supply zone',
          'Broken levels flip roles',
        ],
        Quiz(
          'After a strong breakout above resistance, that level often becomes…',
          ['Support', 'Irrelevant', 'Stronger resistance'],
          0,
          'Old resistance frequently turns into new support.',
        ),
      ),
      Lesson(
        'Trends & Trendlines',
        '3:55',
        [
          (
            'Identifying trends',
            'An uptrend makes higher highs and higher lows; a downtrend makes lower highs and lower lows. "The trend is your friend" until it ends.',
          ),
          (
            'Drawing trendlines',
            'Connect at least two swing lows in an uptrend (or highs in a downtrend). A clean break can signal a change in trend.',
          ),
        ],
        [
          'Higher highs + higher lows = uptrend',
          'Trade with the trend',
          'Trendline breaks warn of change',
        ],
        Quiz(
          'Lower highs and lower lows indicate…',
          ['Uptrend', 'Downtrend', 'Sideways'],
          1,
          'That is the definition of a downtrend.',
        ),
      ),
      Lesson(
        'Moving Averages, RSI & MACD',
        '6:10',
        [
          (
            'Moving averages',
            'A moving average smooths price. The 50-day and 200-day averages are popular; a 50 crossing above 200 is called a "golden cross".',
          ),
          (
            'Momentum indicators',
            'RSI ranges 0–100; above 70 is considered overbought, below 30 oversold. MACD tracks the gap between two averages to show momentum shifts.',
          ),
        ],
        [
          'MAs show trend direction',
          'RSI > 70 overbought, < 30 oversold',
          'Indicators lag price',
        ],
        Quiz(
          'An RSI reading of 25 is generally considered…',
          ['Overbought', 'Oversold', 'Neutral'],
          1,
          'Below 30 is the common oversold zone.',
        ),
      ),
      Lesson(
        'Chart Patterns & Volume',
        '5:15',
        [
          (
            'Popular patterns',
            'Head & Shoulders, Double Top/Bottom, Triangles, Flags and Cup & Handle help traders anticipate breakouts or reversals.',
          ),
          (
            'Volume confirms',
            'Breakouts on high volume are more reliable. A price rise on falling volume may lack conviction.',
          ),
        ],
        [
          'Patterns reflect crowd behaviour',
          'Volume confirms moves',
          'Always set a stop-loss',
        ],
        Quiz(
          'A breakout is more trustworthy when it comes with…',
          ['Low volume', 'High volume', 'No volume'],
          1,
          'High volume shows strong participation.',
        ),
      ),
    ],
  ),

  // ───────────────────────── 4. INTRADAY
  Course(
    id: 'intraday',
    title: 'Intraday Trading',
    category: 'Trading',
    level: 'Advanced',
    emoji: '⚡',
    color: Color(0xFFFF9F6B),
    description:
        'Buy and sell within the same day. Understand margin, popular intraday setups, strict stop-losses and why most beginners lose.',
    lessons: [
      Lesson(
        'What is Intraday Trading?',
        '3:30',
        [
          (
            'Same-day trades',
            'In intraday trading you open and close positions on the same day. Open positions are auto squared-off by the broker before market close (3:30 PM).',
          ),
          (
            'Reality check',
            'Intraday is fast and stressful. Costs (brokerage, STT, slippage) add up quickly, so you need an edge and discipline.',
          ),
        ],
        [
          'Positions close the same day',
          'Market hours 9:15 AM – 3:30 PM',
          'Costs matter a lot',
        ],
        Quiz(
          'What happens to open intraday (MIS) positions near close?',
          ['Carried forward', 'Auto square-off', 'Converted to IPO'],
          1,
          'Brokers auto square-off MIS positions before market close.',
        ),
      ),
      Lesson(
        'Margin & Leverage',
        '4:20',
        [
          (
            'How leverage works',
            'Brokers allow you to take positions larger than your capital (as per SEBI margin rules). Leverage magnifies both profits and losses.',
          ),
          (
            'The danger',
            'With 5x leverage, a 2% move against you is a 10% loss on your capital. Use leverage carefully, if at all.',
          ),
        ],
        [
          'Leverage = borrowed exposure',
          'Losses are magnified too',
          'SEBI sets peak margin rules',
        ],
        Quiz(
          'With 5x leverage, a 2% adverse move costs your capital…',
          ['2%', '5%', '10%'],
          2,
          '2% × 5 = 10% of your capital.',
        ),
      ),
      Lesson(
        'Opening Range Breakout',
        '5:00',
        [
          (
            'The setup',
            'Mark the high and low of the first 15 minutes. A break above the high on volume is a long signal; below the low is a short signal.',
          ),
          (
            'Rules',
            'Place the stop-loss at the other side of the range or mid-range. Avoid trading on low-volume or news-driven gap days without a plan.',
          ),
        ],
        [
          'Uses first 15–30 min range',
          'Volume confirms breakout',
          'Pre-define stop and target',
        ],
        Quiz(
          'ORB stands for…',
          ['Open Rate Bond', 'Opening Range Breakout', 'Order Reject Buffer'],
          1,
          'Opening Range Breakout.',
        ),
      ),
      Lesson(
        'VWAP Strategy',
        '4:35',
        [
          (
            'What is VWAP?',
            'Volume Weighted Average Price is the average price weighted by volume during the day. Institutions use it as a fair-value benchmark.',
          ),
          (
            'Using VWAP',
            'Price above VWAP shows intraday strength; below shows weakness. Pullbacks to VWAP in a trend are common entry points.',
          ),
        ],
        [
          'VWAP resets every day',
          'Above VWAP = bullish bias',
          'Used by big institutions',
        ],
        Quiz(
          'If a stock trades consistently above VWAP, the intraday bias is…',
          ['Bullish', 'Bearish', 'Unknown'],
          0,
          'Staying above VWAP signals buyers are in control.',
        ),
      ),
      Lesson(
        'Risk Rules for Day Traders',
        '4:50',
        [
          (
            'The 1% rule',
            'Never risk more than 1–2% of your total capital on a single trade. Set a daily loss limit and stop trading when you hit it.',
          ),
          (
            'Common mistakes',
            'Over-trading, revenge trading after a loss, moving stop-losses and trading tips blindly are the biggest account killers.',
          ),
        ],
        [
          'Risk max 1–2% per trade',
          'Have a daily loss limit',
          'Never move your stop-loss further',
        ],
        Quiz(
          'After two big losses, the best action is usually to…',
          ['Double position size', 'Stop and review', 'Remove stop-loss'],
          1,
          'Stepping back prevents emotional revenge trading.',
        ),
      ),
    ],
  ),

  // ───────────────────────── 5. SWING
  Course(
    id: 'swing',
    title: 'Swing & Positional Trading',
    category: 'Trading',
    level: 'Intermediate',
    emoji: '🎢',
    color: Color(0xFF7FD3FF),
    description:
        'Hold trades for days to weeks. Combine trend, setups and position sizing to catch bigger moves with less screen time.',
    lessons: [
      Lesson(
        'Swing vs Positional',
        '3:15',
        [
          (
            'Holding periods',
            'Swing trades last a few days to a few weeks; positional trades can last weeks to months. Both use delivery (CNC) so no daily square-off.',
          ),
          (
            'Why swing?',
            'It needs less screen time than intraday and captures larger moves, but you face overnight gap risk.',
          ),
        ],
        [
          'Swing: days to weeks',
          'Positional: weeks to months',
          'Overnight gaps are a risk',
        ],
        Quiz(
          'Swing trades are typically held for…',
          ['Seconds', 'Days to weeks', 'Decades'],
          1,
          'Swing trading spans a few days to weeks.',
        ),
      ),
      Lesson(
        'Finding Swing Setups',
        '4:50',
        [
          (
            'Pullback in trend',
            'Buy strong stocks when they pull back to a moving average (like the 20 EMA) or prior support, then resume the trend.',
          ),
          (
            'Breakouts',
            'Stocks breaking out of multi-week consolidations on high volume often trend for several days.',
          ),
        ],
        [
          'Trade strong stocks in strong sectors',
          'Buy pullbacks in uptrends',
          'Breakouts need volume',
        ],
        Quiz(
          'A classic swing entry in an uptrend is…',
          [
            'Buying a pullback to support',
            'Shorting every rally',
            'Buying random stocks',
          ],
          0,
          'Pullbacks in an uptrend offer better risk-reward.',
        ),
      ),
      Lesson(
        'Position Sizing',
        '4:05',
        [
          (
            'Formula',
            'Position size = (Capital × risk %) ÷ (Entry − Stop-loss). With ₹1,00,000 capital, 1% risk and a ₹10 stop distance, you buy 100 shares.',
          ),
          (
            'Why it matters',
            'Correct sizing keeps any single loss small, so you survive long enough for your edge to work.',
          ),
        ],
        [
          'Size from risk, not conviction',
          'Know your stop before entry',
          'Small losses keep you in the game',
        ],
        Quiz(
          'Capital ₹2,00,000, risk 1%, stop distance ₹20. Quantity = ?',
          ['50', '100', '200'],
          1,
          '2,00,000 × 1% = 2,000 ÷ 20 = 100 shares.',
        ),
      ),
      Lesson(
        'Exits & Trailing Stops',
        '3:40',
        [
          (
            'Planning exits',
            'Set a target with at least 1:2 risk-reward. As price moves in your favour, trail the stop-loss below recent swing lows to lock in gains.',
          ),
          (
            'Let winners run',
            'Cutting winners early and holding losers long is the most common swing-trading error.',
          ),
        ],
        [
          'Aim for 1:2 risk-reward or better',
          'Trail stops to protect profits',
          'Cut losers fast',
        ],
        Quiz(
          'A trailing stop-loss is used to…',
          ['Increase risk', 'Lock in profits as price moves', 'Avoid taxes'],
          1,
          'It moves with the price to protect gains.',
        ),
      ),
    ],
  ),

  // ───────────────────────── 6. F&O BASICS
  Course(
    id: 'fno',
    title: 'Futures & Options (F&O)',
    category: 'F&O',
    level: 'Advanced',
    emoji: '🎯',
    color: Color(0xFFFF8FB1),
    description:
        'Understand derivatives from the ground up: futures, call & put options, strike prices, premium, lot size, margin and expiry.',
    lessons: [
      Lesson(
        'What are Derivatives?',
        '4:00',
        [
          (
            'Value from something else',
            'A derivative is a contract whose value comes from an underlying asset like Nifty, a stock, gold or currency. Futures and Options are the most common.',
          ),
          (
            'Uses',
            'Derivatives are used for hedging (protection), speculation and arbitrage. They involve leverage and high risk.',
          ),
          (
            'Important warning',
            'SEBI studies found that around 9 out of 10 individual F&O traders lost money in recent years. Learn thoroughly before trading real money.',
          ),
        ],
        [
          'Derivative value comes from an underlying',
          'Used for hedging and speculation',
          'Most retail F&O traders lose money',
        ],
        Quiz(
          'Nifty options derive their value from…',
          ['Gold', 'The Nifty 50 index', 'Interest rates only'],
          1,
          'The Nifty 50 index is the underlying.',
        ),
      ),
      Lesson(
        'Futures Contracts',
        '5:10',
        [
          (
            'The agreement',
            'A futures contract is an agreement to buy or sell an asset at a fixed price on a future date. Both buyer and seller are obligated.',
          ),
          (
            'Lot size & margin',
            'Futures trade in fixed lot sizes set by the exchange. You pay only a margin (a fraction of contract value), and profits/losses are settled daily (mark-to-market).',
          ),
        ],
        [
          'Both parties are obligated',
          'Traded in lots with margin',
          'Daily mark-to-market settlement',
        ],
        Quiz(
          'In a futures contract, the buyer…',
          [
            'Has a right but no obligation',
            'Is obligated to buy',
            'Pays only a premium',
          ],
          1,
          'Futures create obligations on both sides.',
        ),
      ),
      Lesson(
        'Call & Put Options',
        '5:45',
        [
          (
            'Call option',
            'A call gives the buyer the RIGHT, not obligation, to buy at the strike price. Buyers profit when the price rises above strike + premium.',
          ),
          (
            'Put option',
            'A put gives the buyer the right to sell at the strike price. Buyers profit when price falls below strike − premium. Option sellers receive the premium but take on large risk.',
          ),
        ],
        [
          'Call = right to buy (bullish)',
          'Put = right to sell (bearish)',
          'Buyer pays premium, seller receives it',
        ],
        Quiz(
          'If you expect a stock to fall, which option would you buy?',
          ['Call', 'Put', 'Neither'],
          1,
          'Put options gain value when the underlying falls.',
        ),
      ),
      Lesson(
        'Strike, Premium & Moneyness',
        '4:30',
        [
          (
            'ITM, ATM, OTM',
            'For calls: strike below market price = In the Money (ITM), equal = At the Money (ATM), above = Out of the Money (OTM). For puts it is reversed.',
          ),
          (
            'Premium',
            'Premium = Intrinsic value + Time value. OTM options have only time value and expire worthless if the price does not reach the strike.',
          ),
        ],
        [
          'Premium = intrinsic + time value',
          'OTM options can expire worthless',
          'Moneyness flips for puts',
        ],
        Quiz(
          'Nifty at 24,000. A 23,800 call option is…',
          ['ITM', 'ATM', 'OTM'],
          0,
          'Strike is below market price, so the call is in the money.',
        ),
      ),
      Lesson(
        'Expiry & Settlement',
        '3:35',
        [
          (
            'Expiry',
            'Every F&O contract has an expiry date. Index options have weekly and monthly expiries as notified by exchanges; stock F&O expire monthly.',
          ),
          (
            'Settlement',
            'Index derivatives are cash-settled. Stock derivatives held to expiry are physically settled – you may need to give or take delivery of shares.',
          ),
        ],
        [
          'Contracts have fixed expiry dates',
          'Index F&O = cash settled',
          'Stock F&O = physical settlement',
        ],
        Quiz(
          'Stock options held ITM until expiry in India are…',
          ['Cash settled', 'Physically settled', 'Cancelled'],
          1,
          'Stock derivatives are physically settled.',
        ),
      ),
      Lesson(
        'Hedging with F&O',
        '4:15',
        [
          (
            'Insurance for a portfolio',
            'Buying a put on Nifty can protect a stock portfolio against a fall – like paying an insurance premium.',
          ),
          (
            'Cost vs protection',
            'Hedges cost money and reduce returns in good times, but limit damage in crashes.',
          ),
        ],
        [
          'Puts can insure a portfolio',
          'Hedging has a cost',
          'Reduces, not removes, risk',
        ],
        Quiz(
          'Buying a Nifty put to protect a portfolio is called…',
          ['Speculation', 'Hedging', 'Arbitrage'],
          1,
          'It is a hedge against downside.',
        ),
      ),
    ],
  ),

  // ───────────────────────── 7. OPTION STRATEGIES
  Course(
    id: 'options-strategies',
    title: 'Option Greeks & Strategies',
    category: 'F&O',
    level: 'Advanced',
    emoji: '🧮',
    color: Color(0xFFC6F06B),
    description:
        'Go deeper into options: Delta, Theta, Vega, implied volatility and popular strategies like spreads, straddles and iron condors.',
    lessons: [
      Lesson(
        'Delta & Gamma',
        '5:00',
        [
          (
            'Delta',
            'Delta shows how much an option price moves for a ₹1 move in the underlying. ATM options have delta around 0.5; deep ITM near 1.',
          ),
          (
            'Gamma',
            'Gamma is the rate of change of delta. It is highest for ATM options close to expiry, making them very sensitive.',
          ),
        ],
        [
          'Delta ≈ price sensitivity',
          'ATM delta ≈ 0.5',
          'Gamma spikes near expiry',
        ],
        Quiz(
          'A call with delta 0.6 – underlying rises ₹10. Option rises about…',
          ['₹6', '₹10', '₹0.6'],
          0,
          '0.6 × 10 = ₹6.',
        ),
      ),
      Lesson(
        'Theta: Time Decay',
        '4:10',
        [
          (
            'Melting ice cube',
            'Options lose time value every day. Theta measures this daily decay. Decay accelerates as expiry gets closer.',
          ),
          (
            'Who benefits',
            'Option buyers fight theta; option sellers earn it – but sellers face potentially large losses on big moves.',
          ),
        ],
        [
          'Time decay hurts buyers',
          'Decay speeds up near expiry',
          'Sellers collect theta but carry big risk',
        ],
        Quiz(
          'Theta works in favour of…',
          ['Option buyers', 'Option sellers', 'Nobody'],
          1,
          'Sellers benefit as the option’s time value decays.',
        ),
      ),
      Lesson(
        'Vega & Implied Volatility',
        '4:40',
        [
          (
            'Implied volatility',
            'IV reflects the market’s expectation of future movement. Higher IV = more expensive options. India VIX tracks Nifty’s expected volatility.',
          ),
          (
            'Vega',
            'Vega shows how much the premium changes for a 1% change in IV. IV often falls sharply after events like results – called "IV crush".',
          ),
        ],
        [
          'High IV = costly premiums',
          'India VIX = fear gauge',
          'Beware IV crush after events',
        ],
        Quiz(
          'After a company’s results, option premiums often drop due to…',
          ['IV crush', 'Dividend', 'Lot size change'],
          0,
          'Uncertainty is resolved, so implied volatility collapses.',
        ),
      ),
      Lesson(
        'Covered Call & Protective Put',
        '4:25',
        [
          (
            'Covered call',
            'Hold shares and sell an OTM call against them to earn premium. You cap upside in return for income.',
          ),
          (
            'Protective put',
            'Hold shares and buy a put to limit downside – like insurance on your stock.',
          ),
        ],
        [
          'Covered call = income, capped upside',
          'Protective put = insurance',
          'Both use stock + option',
        ],
        Quiz(
          'A covered call is created by holding stock and…',
          ['Buying a call', 'Selling a call', 'Buying a put'],
          1,
          'You sell (write) a call against your shares.',
        ),
      ),
      Lesson(
        'Spreads',
        '5:20',
        [
          (
            'Bull call spread',
            'Buy a lower-strike call and sell a higher-strike call. Lower cost than a naked call, with limited profit and limited loss.',
          ),
          (
            'Bear put spread',
            'Buy a higher-strike put and sell a lower-strike put to profit from a moderate fall with defined risk.',
          ),
        ],
        [
          'Spreads define max risk',
          'Cheaper than single options',
          'Profit is capped',
        ],
        Quiz(
          'The main benefit of a spread is…',
          ['Unlimited profit', 'Defined, limited risk', 'No margin ever'],
          1,
          'Both max profit and max loss are known upfront.',
        ),
      ),
      Lesson(
        'Straddle, Strangle & Iron Condor',
        '6:05',
        [
          (
            'Volatility plays',
            'A long straddle buys an ATM call and put – profits from a big move either way. A strangle uses OTM strikes for a lower cost.',
          ),
          (
            'Range plays',
            'An iron condor sells an OTM call spread and put spread, profiting if the market stays in a range. Risk is defined but losses can be quick on big moves.',
          ),
        ],
        [
          'Straddle = bet on big move',
          'Iron condor = bet on range',
          'Know max loss before entry',
        ],
        Quiz(
          'If you expect a huge move but don’t know the direction, use a…',
          ['Long straddle', 'Covered call', 'Iron condor'],
          0,
          'A long straddle profits from big moves in either direction.',
        ),
      ),
    ],
  ),

  // ───────────────────────── 8. MUTUAL FUNDS
  Course(
    id: 'mutual-funds',
    title: 'Mutual Funds Masterclass',
    category: 'Mutual Funds',
    level: 'Beginner',
    emoji: '🪴',
    color: Color(0xFF8EE3A5),
    description:
        'Invest the simple way. Learn NAV, fund types, SIP, direct vs regular plans, expense ratio and how to choose a fund.',
    lessons: [
      Lesson(
        'What is a Mutual Fund?',
        '3:40',
        [
          (
            'Pooled money',
            'A mutual fund pools money from many investors and a professional fund manager invests it in stocks, bonds or both. You own units of the fund.',
          ),
          (
            'Who runs it',
            'Funds are run by AMCs (Asset Management Companies) and regulated by SEBI. AMFI is the industry body.',
          ),
        ],
        [
          'Pooled & professionally managed',
          'You hold units, not shares',
          'Regulated by SEBI',
        ],
        Quiz(
          'Who manages the money in a mutual fund?',
          ['The investor', 'A fund manager at an AMC', 'The stock exchange'],
          1,
          'A professional fund manager at the AMC invests the pool.',
        ),
      ),
      Lesson(
        'NAV Explained',
        '3:05',
        [
          (
            'Net Asset Value',
            'NAV is the per-unit value of a fund: (Total assets − liabilities) ÷ number of units. It is calculated at the end of each business day.',
          ),
          (
            'Myth buster',
            'A low NAV does not mean a fund is "cheap". What matters is the percentage growth of the NAV over time.',
          ),
        ],
        ['NAV = value per unit', 'Updated daily', 'Low NAV ≠ cheap fund'],
        Quiz(
          'Fund A NAV ₹10, Fund B NAV ₹100. Which is cheaper?',
          ['Fund A', 'Fund B', 'NAV alone doesn’t tell you'],
          2,
          'Returns depend on percentage change, not the NAV level.',
        ),
      ),
      Lesson(
        'Types of Funds',
        '4:50',
        [
          (
            'Equity funds',
            'Large cap, mid cap, small cap, flexi cap and sectoral funds invest mostly in stocks. Higher risk, higher long-term return potential.',
          ),
          (
            'Debt & hybrid',
            'Debt funds invest in bonds and money-market instruments for stability. Hybrid funds mix equity and debt. Index funds simply track an index.',
          ),
        ],
        [
          'Equity = growth, more volatile',
          'Debt = stability',
          'Hybrid = mix of both',
        ],
        Quiz(
          'Which fund type tracks an index like Nifty 50?',
          ['Sectoral fund', 'Index fund', 'Liquid fund'],
          1,
          'Index funds replicate an index.',
        ),
      ),
      Lesson(
        'SIP, Lumpsum, SWP & STP',
        '5:00',
        [
          (
            'SIP',
            'A Systematic Investment Plan invests a fixed amount every month. It builds discipline and averages your purchase cost (rupee cost averaging).',
          ),
          (
            'SWP & STP',
            'SWP withdraws a fixed amount regularly – useful in retirement. STP moves money gradually from one fund (often debt) to another (often equity).',
          ),
        ],
        [
          'SIP = regular investing',
          'Rupee cost averaging',
          'SWP for regular income',
        ],
        Quiz(
          'Rupee cost averaging means…',
          [
            'Buying more units when prices are low',
            'Getting fixed returns',
            'Avoiding all losses',
          ],
          0,
          'A fixed SIP amount buys more units when NAV is lower.',
        ),
      ),
      Lesson(
        'Direct vs Regular & Expense Ratio',
        '4:00',
        [
          (
            'Expense ratio',
            'The fund charges an annual fee called the expense ratio, deducted from NAV. Even 1% a year makes a big difference over 20 years.',
          ),
          (
            'Direct vs regular',
            'Direct plans have no distributor commission, so lower expense ratios. Regular plans pay commission to a distributor who may provide advice.',
          ),
        ],
        [
          'Expense ratio is an annual cost',
          'Direct plans cost less',
          'Small costs compound over time',
        ],
        Quiz(
          'Which plan usually has a lower expense ratio?',
          ['Regular', 'Direct', 'Both same'],
          1,
          'Direct plans exclude distributor commissions.',
        ),
      ),
      Lesson(
        'ELSS & Choosing a Fund',
        '4:35',
        [
          (
            'ELSS',
            'Equity Linked Savings Schemes are equity funds with a 3-year lock-in that qualify for tax deduction under Section 80C in the old tax regime.',
          ),
          (
            'Choosing',
            'Check your goal and time horizon, the fund’s category, long-term consistency vs benchmark, expense ratio and fund house quality – not just last year’s return.',
          ),
        ],
        [
          'ELSS lock-in = 3 years',
          'Match fund to goal & horizon',
          'Past returns don’t guarantee future',
        ],
        Quiz(
          'What is the lock-in period of ELSS?',
          ['1 year', '3 years', '5 years'],
          1,
          'ELSS has a 3-year lock-in, the shortest among 80C options.',
        ),
      ),
    ],
  ),

  // ───────────────────────── 9. ETFs
  Course(
    id: 'etf',
    title: 'ETFs & Index Investing',
    category: 'Mutual Funds',
    level: 'Beginner',
    emoji: '🧺',
    color: Color(0xFFFFC2E0),
    description:
        'Own the whole market at low cost. Learn how ETFs work, index funds vs ETFs, tracking error and passive investing.',
    lessons: [
      Lesson(
        'What is an ETF?',
        '3:25',
        [
          (
            'Exchange Traded Fund',
            'An ETF holds a basket of assets (like Nifty 50 stocks or gold) and trades on the exchange like a share, at live prices.',
          ),
          (
            'Popular ETFs',
            'Nifty 50 ETFs, Bank Nifty ETFs, Gold ETFs, Silver ETFs and international ETFs are widely used in India.',
          ),
        ],
        [
          'ETFs trade like shares',
          'Need a Demat account',
          'Low cost diversification',
        ],
        Quiz(
          'How do you buy an ETF?',
          ['Only from the AMC', 'On the stock exchange', 'At a bank counter'],
          1,
          'ETFs are listed and traded on exchanges.',
        ),
      ),
      Lesson(
        'Index Fund vs ETF',
        '3:50',
        [
          (
            'Key differences',
            'Index funds are bought at end-of-day NAV from the AMC and support SIPs easily. ETFs trade intraday and need a Demat account.',
          ),
          (
            'Liquidity',
            'Some ETFs have low trading volume, so price can differ from real value. Prefer ETFs with good liquidity.',
          ),
        ],
        [
          'Index fund = NAV based',
          'ETF = live market price',
          'Check ETF liquidity',
        ],
        Quiz(
          'Which one needs a Demat account?',
          ['Index fund', 'ETF', 'Neither'],
          1,
          'ETFs are held in Demat since they trade on exchanges.',
        ),
      ),
      Lesson(
        'Tracking Error',
        '3:10',
        [
          (
            'Not perfect copies',
            'Tracking error measures how closely a fund follows its index. Costs and cash holdings cause small differences.',
          ),
          (
            'Pick wisely',
            'Among funds tracking the same index, prefer lower expense ratio and lower tracking error.',
          ),
        ],
        [
          'Lower tracking error = better',
          'Expense ratio matters',
          'Compare funds on the same index',
        ],
        Quiz(
          'Tracking error measures…',
          ['Fund’s deviation from its index', 'Broker errors', 'Tax payable'],
          0,
          'It shows how far returns deviate from the index.',
        ),
      ),
      Lesson(
        'Power of Passive Investing',
        '4:15',
        [
          (
            'Why passive works',
            'Over long periods many active funds fail to beat their benchmark after costs. Passive investing gives market returns at low cost.',
          ),
          (
            'Compounding',
            'Staying invested and adding regularly lets compounding work – time in the market beats timing the market.',
          ),
        ],
        [
          'Low cost + diversification',
          'Hard to beat the index long-term',
          'Compounding needs time',
        ],
        Quiz(
          '"Time in the market beats timing the market" encourages…',
          ['Frequent trading', 'Staying invested long-term', 'Avoiding stocks'],
          1,
          'Long-term holding lets compounding work.',
        ),
      ),
    ],
  ),

  // ───────────────────────── 10. IPO
  Course(
    id: 'ipo',
    title: 'IPO Investing',
    category: 'Stocks',
    level: 'Beginner',
    emoji: '🚀',
    color: Color(0xFFFFB86B),
    description:
        'Everything about IPOs: how they work, how to apply with UPI, reading the DRHP, allotment, GMP and listing day.',
    lessons: [
      Lesson(
        'How an IPO Works',
        '3:45',
        [
          (
            'Going public',
            'An Initial Public Offering is when a private company sells shares to the public for the first time and lists on NSE/BSE.',
          ),
          (
            'Fresh issue vs OFS',
            'In a fresh issue the money goes to the company. In an Offer For Sale (OFS), existing shareholders sell and the money goes to them.',
          ),
        ],
        [
          'IPO = first public share sale',
          'Fresh issue funds the company',
          'OFS lets existing owners exit',
        ],
        Quiz(
          'In an Offer For Sale, money goes to…',
          ['The company', 'Selling shareholders', 'SEBI'],
          1,
          'OFS proceeds go to the selling shareholders.',
        ),
      ),
      Lesson(
        'Applying via UPI / ASBA',
        '3:20',
        [
          (
            'ASBA',
            'Application Supported by Blocked Amount: your money stays in your bank but is blocked until allotment. With UPI, you approve a mandate in your UPI app.',
          ),
          (
            'Bidding',
            'Retail investors bid in lots within the price band. Bidding at "cut-off" means you accept the final price.',
          ),
        ],
        [
          'Money is blocked, not debited',
          'Approve the UPI mandate in time',
          'Bid at cut-off price',
        ],
        Quiz(
          'In ASBA, your application money is…',
          ['Debited immediately', 'Blocked until allotment', 'Paid in cash'],
          1,
          'It stays blocked in your account until allotment.',
        ),
      ),
      Lesson(
        'Reading the DRHP',
        '4:30',
        [
          (
            'The offer document',
            'The Draft Red Herring Prospectus contains business details, financials, risks, promoter information and use of funds.',
          ),
          (
            'What to check',
            'Revenue and profit trend, debt, valuation vs listed peers, objects of the issue and the risk factors section.',
          ),
        ],
        [
          'DRHP = IPO’s detailed document',
          'Read risk factors carefully',
          'Compare valuation with peers',
        ],
        Quiz(
          'Where can you find an IPO company’s risk factors?',
          ['Social media', 'The DRHP/RHP', 'Stock ticker'],
          1,
          'Risk factors are listed in the offer document.',
        ),
      ),
      Lesson(
        'Allotment, GMP & Listing',
        '4:05',
        [
          (
            'Allotment',
            'If oversubscribed, retail allotment is done by lottery. Unallotted funds are unblocked. Shares are credited before listing day.',
          ),
          (
            'Grey Market Premium',
            'GMP is an unofficial, unregulated indicator of expected listing price. It is not reliable and can change quickly.',
          ),
        ],
        [
          'Retail allotment is by lottery',
          'GMP is unofficial and unreliable',
          'Listing gains are never guaranteed',
        ],
        Quiz(
          'GMP is…',
          [
            'SEBI-approved price',
            'An unofficial grey market indicator',
            'Guaranteed listing price',
          ],
          1,
          'GMP is unofficial and unregulated.',
        ),
      ),
    ],
  ),

  // ───────────────────────── 11. COMMODITY & CURRENCY
  Course(
    id: 'commodity',
    title: 'Commodity & Currency Markets',
    category: 'Commodities',
    level: 'Intermediate',
    emoji: '🥇',
    color: Color(0xFFF7E26B),
    description:
        'Trade beyond stocks: gold, silver, crude oil on MCX and currency pairs like USD/INR. Learn what drives these markets.',
    lessons: [
      Lesson(
        'Introduction to Commodities',
        '3:40',
        [
          (
            'What are commodities?',
            'Commodities are raw materials: bullion (gold, silver), energy (crude oil, natural gas), base metals (copper, zinc) and agri products.',
          ),
          (
            'Exchanges',
            'MCX is India’s main commodity exchange; NCDEX focuses on agri commodities. Trading happens mostly through futures and options.',
          ),
        ],
        [
          'MCX = main commodity exchange',
          'Traded via derivatives',
          'Longer hours than equity',
        ],
        Quiz(
          'Which is India’s main commodity exchange?',
          ['NSE', 'MCX', 'NSDL'],
          1,
          'MCX (Multi Commodity Exchange).',
        ),
      ),
      Lesson(
        'Gold & Silver',
        '4:10',
        [
          (
            'Safe haven',
            'Gold tends to do well during uncertainty and high inflation. Prices in India depend on global prices and the USD/INR rate.',
          ),
          (
            'Ways to invest',
            'Gold ETFs, gold mutual funds, Sovereign Gold Bonds (where available) and MCX futures – each has different costs and risks.',
          ),
        ],
        [
          'Gold = hedge in uncertain times',
          'Rupee movement affects gold price',
          'Many ways to invest digitally',
        ],
        Quiz(
          'A weaker rupee generally makes gold prices in India…',
          ['Higher', 'Lower', 'Unchanged'],
          0,
          'Gold is priced in dollars, so a weaker rupee raises the INR price.',
        ),
      ),
      Lesson(
        'Crude Oil',
        '3:55',
        [
          (
            'What moves crude',
            'Supply decisions (OPEC+), global demand, inventories and geopolitics drive crude prices. It is one of the most volatile commodities.',
          ),
          (
            'Impact on India',
            'India imports most of its oil, so high crude prices can raise inflation and pressure the rupee and some stocks.',
          ),
        ],
        [
          'OPEC+ and geopolitics matter',
          'Very volatile',
          'Affects India’s inflation',
        ],
        Quiz(
          'Rising crude oil prices are usually negative for…',
          ['Oil-importing economies like India', 'Oil producers', 'Nobody'],
          0,
          'India is a large oil importer.',
        ),
      ),
      Lesson(
        'Currency Pairs & USD/INR',
        '4:20',
        [
          (
            'Reading a pair',
            'USD/INR = 84 means 1 US dollar costs ₹84. If it rises to 85, the rupee has weakened.',
          ),
          (
            'What drives it',
            'Interest rate differences, trade deficit, foreign investment flows and RBI intervention move the rupee.',
          ),
        ],
        [
          'Pair shows price of base in quote',
          'USD/INR up = rupee weaker',
          'RBI manages volatility',
        ],
        Quiz(
          'USD/INR moves from 84 to 86. The rupee has…',
          ['Strengthened', 'Weakened', 'Stayed same'],
          1,
          'More rupees are needed per dollar, so the rupee weakened.',
        ),
      ),
    ],
  ),

  // ───────────────────────── 12. BONDS
  Course(
    id: 'bonds',
    title: 'Bonds & Fixed Income',
    category: 'Fixed Income',
    level: 'Beginner',
    emoji: '🏦',
    color: Color(0xFFA7D8FF),
    description:
        'Learn how bonds work, yields vs prices, government securities, corporate bonds and credit ratings.',
    lessons: [
      Lesson(
        'What is a Bond?',
        '3:30',
        [
          (
            'Lending money',
            'A bond is a loan you give to a government or company. In return you get regular interest (coupon) and your principal back at maturity.',
          ),
          (
            'Lower risk',
            'Bonds are generally less volatile than stocks and help balance a portfolio.',
          ),
        ],
        [
          'Bond = loan to issuer',
          'Coupon = interest payment',
          'Principal returned at maturity',
        ],
        Quiz(
          'The regular interest paid on a bond is called…',
          ['Dividend', 'Coupon', 'Premium'],
          1,
          'Bond interest payments are called coupons.',
        ),
      ),
      Lesson(
        'Yield vs Price',
        '4:15',
        [
          (
            'Inverse relationship',
            'When interest rates rise, existing bond prices fall (and yields rise). When rates fall, bond prices rise.',
          ),
          (
            'Duration',
            'Longer-maturity bonds are more sensitive to interest rate changes.',
          ),
        ],
        [
          'Rates up → bond prices down',
          'Yield = effective return',
          'Long bonds = more rate risk',
        ],
        Quiz(
          'If interest rates rise, existing bond prices usually…',
          ['Rise', 'Fall', 'Stay same'],
          1,
          'Price and yield move in opposite directions.',
        ),
      ),
      Lesson(
        'G-Secs & RBI Retail Direct',
        '3:40',
        [
          (
            'Government securities',
            'G-Secs and Treasury Bills are issued by the government and carry virtually no default risk.',
          ),
          (
            'Retail access',
            'Individuals can buy G-Secs directly through the RBI Retail Direct platform or via brokers and gilt funds.',
          ),
        ],
        [
          'G-Secs = sovereign backed',
          'T-Bills are short-term',
          'RBI Retail Direct for individuals',
        ],
        Quiz(
          'Which bonds have the lowest default risk in India?',
          ['Corporate bonds', 'Government securities', 'Startup bonds'],
          1,
          'G-Secs are backed by the Government of India.',
        ),
      ),
      Lesson(
        'Corporate Bonds & Credit Ratings',
        '4:00',
        [
          (
            'Higher yield, higher risk',
            'Companies pay higher interest than the government because there is a risk they may default.',
          ),
          (
            'Ratings',
            'Agencies like CRISIL, ICRA and CARE rate bonds. AAA is the highest safety; below BBB is considered high risk (junk).',
          ),
        ],
        [
          'Corporate bonds carry credit risk',
          'AAA = highest safety',
          'Higher yield often means higher risk',
        ],
        Quiz(
          'Which rating indicates the highest safety?',
          ['BBB', 'AA', 'AAA'],
          2,
          'AAA is the top credit rating.',
        ),
      ),
    ],
  ),

  // ───────────────────────── 13. PSYCHOLOGY & RISK
  Course(
    id: 'psychology',
    title: 'Trading Psychology & Risk',
    category: 'Trading',
    level: 'Beginner',
    emoji: '🧠',
    color: Color(0xFFD7C2FF),
    description:
        'Your mind is your biggest risk. Learn how emotions and biases affect decisions, and build a risk-management system that lasts.',
    lessons: [
      Lesson(
        'Loss Aversion',
        '4:10',
        [
          (
            'Losses hurt more',
            'Losing ₹1,000 feels roughly twice as painful as gaining ₹1,000 feels good. This makes traders hold losers too long hoping to break even.',
          ),
          (
            'The fix',
            'Decide your exit before entering a trade and follow it mechanically.',
          ),
        ],
        [
          'Losses feel ~2x stronger than gains',
          'Leads to holding losers',
          'Pre-plan exits',
        ],
        Quiz(
          'Loss aversion often causes traders to…',
          ['Cut losses fast', 'Hold losing trades too long', 'Diversify more'],
          1,
          'Fear of realising a loss keeps people in bad trades.',
        ),
      ),
      Lesson(
        'FOMO & Herd Mentality',
        '3:45',
        [
          (
            'Fear of missing out',
            'Buying because everyone else is buying – often near the top. Social media tips amplify this.',
          ),
          (
            'Herding',
            'Crowds can push prices far beyond value in bubbles and far below in panics.',
          ),
        ],
        ['FOMO buys tops', 'Crowds create bubbles', 'Stick to your own plan'],
        Quiz(
          'Buying a stock only because it’s trending on social media is an example of…',
          ['Research', 'FOMO / herding', 'Hedging'],
          1,
          'That is classic herd behaviour.',
        ),
      ),
      Lesson(
        'Overconfidence & Confirmation Bias',
        '3:55',
        [
          (
            'Overconfidence',
            'After a few wins, traders increase size and take more risk, often leading to a big loss.',
          ),
          (
            'Confirmation bias',
            'We look for information that agrees with us and ignore warnings. Actively seek the opposite view.',
          ),
        ],
        [
          'Wins can breed overconfidence',
          'Seek opposing views',
          'Keep position sizes consistent',
        ],
        Quiz(
          'Only reading news that supports your trade is…',
          ['Confirmation bias', 'Diversification', 'Arbitrage'],
          0,
          'That is confirmation bias.',
        ),
      ),
      Lesson(
        'Risk–Reward & Diversification',
        '4:30',
        [
          (
            'Risk-reward',
            'Taking trades with 1:2 risk-reward means you can be right only 40% of the time and still be profitable (before costs).',
          ),
          (
            'Diversification',
            'Spread investments across stocks, sectors and asset classes so no single loss can sink you.',
          ),
        ],
        [
          'Aim for favourable risk-reward',
          'Don’t put all eggs in one basket',
          'Protect capital first',
        ],
        Quiz(
          'With 1:2 risk-reward, roughly what win rate breaks even (ignoring costs)?',
          ['33%', '50%', '80%'],
          0,
          'Win 1 × 2 = lose 2 × 1 → about one-third win rate.',
        ),
      ),
      Lesson(
        'Trading Journal',
        '3:15',
        [
          (
            'Track everything',
            'Record entry, exit, reason, emotions and result for every trade. Review weekly to find patterns in your mistakes.',
          ),
          (
            'Improve with data',
            'A journal turns trading from guessing into a process you can measure and improve.',
          ),
        ],
        ['Log every trade', 'Record emotions too', 'Review weekly'],
        Quiz(
          'The main purpose of a trading journal is to…',
          [
            'Show off profits',
            'Learn from patterns in your trades',
            'Avoid tax',
          ],
          1,
          'Reviewing records helps you fix repeated mistakes.',
        ),
      ),
    ],
  ),

  // ───────────────────────── 14. TAX
  Course(
    id: 'tax',
    title: 'Stock Market Taxation',
    category: 'Tax',
    level: 'Intermediate',
    emoji: '🧾',
    color: Color(0xFFFFA7A7),
    description:
        'Understand how gains from shares, mutual funds and F&O are taxed in India, plus STT, dividends and filing basics.',
    lessons: [
      Lesson(
        'STCG & LTCG on Equity',
        '4:40',
        [
          (
            'Short-term',
            'Listed equity shares and equity funds sold within 12 months give Short-Term Capital Gains, taxed at 20% (rates as per Budget 2024 – always verify current rules).',
          ),
          (
            'Long-term',
            'Held over 12 months = Long-Term Capital Gains, taxed at 12.5% on gains above ₹1.25 lakh per financial year.',
          ),
        ],
        [
          '< 12 months = short-term',
          '> 12 months = long-term',
          'LTCG exemption up to ₹1.25 lakh/year',
        ],
        Quiz(
          'Equity shares held for 18 months and sold at a profit give…',
          ['STCG', 'LTCG', 'Business income'],
          1,
          'Holding over 12 months makes it long-term.',
        ),
      ),
      Lesson(
        'Intraday & F&O Income',
        '4:20',
        [
          (
            'Intraday',
            'Intraday equity profits are treated as speculative business income and taxed at your slab rate.',
          ),
          (
            'F&O',
            'F&O trading is treated as non-speculative business income, taxed at slab rates. You file ITR-3, and a tax audit may apply above certain turnover limits.',
          ),
        ],
        [
          'Intraday = speculative income',
          'F&O = non-speculative business income',
          'File ITR-3',
        ],
        Quiz(
          'F&O profits are generally taxed as…',
          ['Capital gains', 'Non-speculative business income', 'Tax-free'],
          1,
          'F&O income is non-speculative business income.',
        ),
      ),
      Lesson(
        'STT & Other Charges',
        '3:30',
        [
          (
            'Securities Transaction Tax',
            'STT is charged on buying/selling securities on exchanges. Rates differ for delivery, intraday, futures and options.',
          ),
          (
            'Other costs',
            'Brokerage, exchange charges, SEBI fees, GST and stamp duty – check your contract note to see the full cost of every trade.',
          ),
        ],
        [
          'STT applies on every trade',
          'Contract note shows all charges',
          'Costs reduce net profit',
        ],
        Quiz(
          'Where can you see all charges for a trade?',
          ['Contract note', 'Annual report', 'Index factsheet'],
          0,
          'The broker’s contract note lists all charges.',
        ),
      ),
      Lesson(
        'Dividends & Loss Set-off',
        '3:50',
        [
          (
            'Dividends',
            'Dividends are added to your income and taxed at your slab rate. Companies deduct TDS above a threshold.',
          ),
          (
            'Set-off losses',
            'Capital losses can be set off against capital gains and carried forward for 8 years if you file returns on time.',
          ),
        ],
        [
          'Dividends taxed at slab rate',
          'Losses can be carried forward 8 years',
          'File ITR on time',
        ],
        Quiz(
          'For how many years can capital losses be carried forward?',
          ['2', '4', '8'],
          2,
          'Capital losses can be carried forward for 8 assessment years.',
        ),
      ),
    ],
  ),
];
