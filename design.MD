# Habit Tracker App UI Design Specification

## 1. Global Theme & Styling

- **Design System:** Mobile-first, Clean, Minimalist, iOS-inspired rounded corners.
- **Color Palette:**
  - **Background:** `#F9FAFB` (Light Mode) / `#111827` (Dark Mode - optional support).
  - **Surface/Card:** `#FFFFFF` (White) with subtle shadow (`shadow-sm`).
  - **Primary Brand Color:** `#6366F1` (Indigo - for active states and primary buttons).
  - **Success Color:** `#10B981` (Emerald - for completed habits).
  - **Text Primary:** `#1F2937` (Dark Gray).
  - **Text Secondary:** `#6B7280` (Medium Gray).
- **Typography:** Sans-serif (Inter or system default like San Francisco).
  - Headings: Bold, clean, large tracking.
  - Body: Regular, highly readable.
- **Border Radius:** Use `rounded-2xl` for cards and `rounded-full` for buttons/icons.

## 2. Screens Overview

### Screen 1: Home / Dashboard (Today's Overview)

**Layout:** Single column, vertical scroll.
**Components:**

- **Header:**
  - Left: Greeting text (e.g., "Halo, Selamat Pagi! 👋") and current date text (e.g., "13 Mei 2026").
  - Right: User avatar or profile icon.
- **Summary Section (Card):**
  - Horizontal flexbox.
  - Left side: "Daily Progress" text with a fraction (e.g., "3/5 Completed").
  - Right side: Circular progress indicator (ring) showing completion percentage in Emerald color.
- **Habits List (Today):**
  - Section title: "Kebiasaan Hari Ini".
  - **Habit Item Card (Repeated list):**
    - Flex row layout.
    - Left: Icon block with a light background matching the habit's theme color.
    - Middle: Habit Name (bold) and current streak (e.g., "🔥 5 hari berturut-turut").
    - Right: A large, tappable circle checkbox. If completed, it fills with the Success Color and shows a checkmark icon.
- **Floating Action Button (FAB):**
  - Position: Bottom right.
  - Style: Large circular button (`rounded-full`), Primary Brand Color, with a prominent white "+" icon.

### Screen 2: Add New Habit (Modal / Bottom Sheet)

**Layout:** Card overlay or bottom sheet sliding up.
**Components:**

- **Header:** Title "Buat Kebiasaan Baru", with a "Batal" (Cancel) button on the left and "Simpan" (Save) button on the right.
- **Form Fields:**
  - **Habit Name:** Large, borderless text input (Placeholder: "Membaca buku, Olahraga...").
  - **Icon Selection:** A horizontal scrolling row of 5-6 selectable generic icons.
  - **Color Picker:** A horizontal row of 5 circular color swatches to tag the habit.
  - **Frequency Selector:** A row of 7 circular buttons representing days of the week (S, S, R, K, J, S, M). Active days are highlighted in the Primary Brand Color.
  - **Reminder Toggle:** A row with text "Aktifkan Pengingat" and a standard UI switch component aligned to the right.

### Screen 3: Habit Detail & Statistics

**Layout:** Single column, vertical scroll.
**Components:**

- **Header:** Back button (`<`) on the left, Habit Icon and Name centered. Menu icon (`...`) on the right for edit/delete.
- **Streak Status Card:**
  - Large centered number showing "Current Streak".
  - Subtitle: "Hari berturut-turut".
  - Secondary stats below it: "Best Streak" and "Total Completions" in a 2-column grid.
- **Calendar Heatmap:**
  - A grid representing the current month.
  - Days where the habit was completed are filled with the habit's assigned color.
  - Days missed are grayed out.

## 3. Interactive Behaviors & Animations

- **Checking a Habit:** When the user taps the empty circle on the Home screen, it should scale up slightly, vibrate (conceptually), fill with the green success color, and play a checkmark animation.
- **Transitions:** Smooth slide-up transition for the "Add New Habit" bottom sheet.
- **Scrolling:** Hide the FAB slightly when scrolling down the habits list to maximize reading space.
