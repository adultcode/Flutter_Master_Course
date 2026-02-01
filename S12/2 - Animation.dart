<?php
/**
 * Template for Single Product on Sie
 */
$course_counters = true;
$course_students = true;
if (class_exists('Redux')) {
    $course_post_share = codebean_option('course_share_story');
    $course_share_text = codebean_option('course_share_text');
    $course_students = codebean_option('course_students');
    $course_counters = codebean_option('course_counters');
    $course_student_text = codebean_option('course_student_text');
    $course_downloads = codebean_option('course_downloads');
    $course_purchase = codebean_option('course_purchase');
} else {
    $course_post_share = false;
    $course_share_text = '';
}

$student_display = true;
$prefix = '_studiare_';

// Product Meta
$course_stock = get_post_meta(get_the_id(), '_stock', true);
$duration = get_post_meta(get_the_ID(), $prefix . 'course_duration', true);
$lessons = get_post_meta(get_the_ID(), $prefix . 'course_lesseons', true);
$skill_level = get_post_meta(get_the_ID(), $prefix . 'course_level', true);
$certificate = get_post_meta(get_the_ID(), $prefix . 'course_certificate', true);
$course_language = get_post_meta(get_the_ID(), $prefix . 'course_language', true);
$course_type = get_post_meta(get_the_ID(), $prefix . 'course_type', true);
$course_prerequisite = get_post_meta(get_the_ID(), $prefix . 'course_prerequisite', true);
$course_start_date = get_post_meta(get_the_ID(), $prefix . 'course_start_date', true);
$course_update_date = get_post_meta(get_the_ID(), $prefix . 'course_update_date', true);
$course_file_size = get_post_meta(get_the_ID(), $prefix . 'course_file_size', true);
$course_support = get_post_meta(get_the_ID(), $prefix . 'course_support', true);
$course_receive_type = get_post_meta(get_the_ID(), $prefix . 'course_receive_type', true);
$extra_content = get_post_meta(get_the_ID(), $prefix . 'extra_content', true);
$course_percent = get_post_meta(get_the_ID(), $prefix . 'course_percent', true);

global $product;
$downloads = array();
if (is_user_logged_in()) {
    $user_id = get_current_user_id();
    $downloads = wc_get_customer_available_downloads($user_id);
}
?>

<div class="product-info-box std-add-t-cart">

    <?php

    $current_user = wp_get_current_user();
    if (wc_customer_bought_product($current_user->user_email, $current_user->ID, $product->get_id()) && ($course_purchase)) {
        echo ' ';
    } else {
        do_action('woocommerce_single_product_countdown');
    }

    ?>


    <?php
    $current_user = wp_get_current_user();
    if (wc_customer_bought_product($current_user->user_email, $current_user->ID, $product->get_id()) && ($course_purchase)) {
        echo '<div class="purchased-info-box">';
        echo '<i class="fas fa-graduation-cap"></i>';
        echo($course_student_text);
        echo '</div>';
    } else {
        do_action('woocommerce_single_product_summary');
    }
    ?>
    <?php if ($extra_content) : ?>
        <?php echo($extra_content); ?>
    <?php endif; ?>
    <div class="average-rating-sidebar">
        <div class="avareage-rating-inner">
            <div class="average-rating-number"><span class="title-rate">امتیاز</span>
                <div class="schema-stars">
                    <span><?php $average = $product->get_average_rating();
                        echo esc_attr($average); ?></span>
                    <span class="title-rate">از</span>
                    <span><?php $rating_count = $product->get_rating_count();
                        echo esc_attr($rating_count); ?></span>
                    <span class="title-rate">رأی</span>
                </div>
            </div>
            <div class="average-rating-stars">
                <?php do_action('woocommerce_after_shop_loop_item_title'); ?>
            </div>

        </div>
    </div>
</div>

<?php if ($course_downloads) : ?>
    <?php if (wc_customer_bought_product($current_user->user_email, $current_user->ID, $product->get_id())) : ?>
        <ul class="wcdlar_download_list produc-page">
            <li>
                <?php echo '<a href="#" class="title">دریافت فایل های دوره<span class="arrow"></span></a>'; ?>
                <div class="sub_items">
                    <table>
                        <?php foreach ($downloads as $download) : ?>
                            <?php if ($download['product_id'] === $product->get_id()) : ?>
                                <tr>
                                    <td><?php echo '<a href="' . $download['download_url'] . '" class="download-btns-product-page"><i class="fal fa-download"></i> ' . $download ['file']['name'] . ' </a>'; ?></td>
                                </tr>
                            <?php endif; ?>
                        <?php endforeach; ?>
                    </table>
                </div>
            </li>
        </ul>
    <?php endif; ?>
<?php endif; ?>

<div class="product-info-box">
    <?php if (!empty($course_stock) || !empty($course_language) || !empty($duration) || !empty($lessons) || !empty($skill_level) || !empty($certificate) || !empty($course_start_date) || !empty($course_prerequisite) || !empty($course_receive_type) || !empty($course_update_date) || !empty($feture_entries)) : ?>
        <div class="product-meta-info-list">


            <?php if ($course_students) : ?>
                <div class="total_sales">
                    <i class="fal fa-user-graduate"></i> تعداد دانشجو :
                    <span><?php $count = get_post_meta($post->ID, 'total_sales', true);
                        $text = sprintf(_n('%s', '%s', $count, 'wpdocs_textdomain'), number_format_i18n($count));
                        echo $text; ?></span>
                </div>
            <?php endif; ?>

            <?php if (!empty($course_type)) : ?>
                <div class="meta-info-unit">
                    <div class="icon"><i class="fal fa-map-marker-alt"></i></div>
                    <div class="value"><?php echo esc_attr(__('نوع دوره:', 'studiare') . ' ' . $course_type); ?></div>
                </div>
            <?php endif; ?>

            <?php if (!empty($skill_level)) : ?>
                <div class="meta-info-unit">
                    <div class="icon"><i class="fal fa-book-reader"></i></div>
                    <div class="value"><?php echo esc_attr(__('Study Level:', 'studiare') . ' ' . $skill_level); ?></div>
                </div>
            <?php endif; ?>

            <?php if (!empty($course_prerequisite)) : ?>
                <div class="meta-info-unit">
                    <div class="icon"><i class="fal fa-traffic-light-slow"></i></div>
                    <div class="value"><?php echo esc_attr(__('پیش نیاز:', 'studiare') . ' ' . $course_prerequisite); ?></div>
                </div>
            <?php endif; ?>

            <?php if (!empty($course_start_date)) : ?>
                <div class="meta-info-unit">
                    <div class="icon"><i class="fal fa-calendar-day"></i></div>
                    <div class="value"><?php echo esc_attr(__('تاریخ شروع:', 'studiare') . ' ' . $course_start_date); ?></div>
                </div>
            <?php endif; ?>

            <?php if (!empty($course_update_date)) : ?>
                <div class="meta-info-unit">
                    <div class="icon"><i class="fal fa-calendar-edit"></i></div>
                    <div class="value"><?php echo esc_attr(__('تاریخ بروزرسانی:', 'studiare') . ' ' . $course_update_date); ?></div>
                </div>
            <?php endif; ?>

            <?php if (!empty($course_language)) : ?>
                <div class="meta-info-unit">
                    <div class="icon"><i class="fal fa-globe"></i></div>
                    <div class="value"><?php echo esc_attr(__('Language:', 'studiare') . ' ' . $course_language); ?></div>
                </div>
            <?php endif; ?>

            <?php if (!empty($duration)) : ?>
                <div class="meta-info-unit">
                    <div class="icon"><i class="fal fa-clock"></i></div>
                    <div class="value"><?php echo esc_html($duration); ?></div>
                </div>
            <?php endif; ?>

            <?php if (!empty($lessons)) : ?>
                <div class="meta-info-unit">
                    <div class="icon"><i class="fal fa-list-alt"></i></div>
                    <div class="value"><?php echo esc_html($lessons); ?></div>
                </div>
            <?php endif; ?>

            <?php if (!empty($course_file_size)) : ?>
                <div class="meta-info-unit">
                    <div class="icon"><i class="fal fa-hdd"></i></div>
                    <div class="value"><?php echo esc_attr(__('', 'studiare') . ' ' . $course_file_size); ?></div>
                </div>
            <?php endif; ?>


            <?php if (!empty($course_receive_type)) : ?>
                <div class="meta-info-unit">
                    <div class="icon"><i class="fal fa-long-arrow-alt-down"></i></div>
                    <div class="value"><?php echo esc_attr(__('روش دریافت:', 'studiare') . ' ' . $course_receive_type); ?></div>
                </div>
            <?php endif; ?>


            <?php if (!empty($course_support)) : ?>
                <div class="meta-info-unit">
                    <div class="icon"><i class="fal fa-user-headset"></i></div>
                    <div class="value"><?php echo esc_attr(__('روش پشتیبانی:', 'studiare') . ' ' . $course_support); ?></div>
                </div>
            <?php endif; ?>

            <?php if (!empty($certificate)) : ?>
                <div class="meta-info-unit">
                    <div class="icon"><i class="fal fa-file-certificate"></i></div>
                    <div class="value"><?php echo esc_html($certificate); ?></div>
                </div>
            <?php endif; ?>

            <?php

            $feture_entries = get_post_meta(get_the_ID(), 'feture_group', true);
            if ($feture_entries) {
                foreach ($feture_entries as $key => $entry) { ?>

                    <div class="meta-info-unit">
                        <div class="icon"><i class="fal fa-check"></i></div>
                        <div class="value"><?php echo esc_html($entry[$prefix . 'feture_title']); ?> :
                            <span> <?php echo esc_html($entry[$prefix . 'feture_input']); ?></span></div>
                    </div>
                <?php }
            } ?>


        </div>

        <?php if (!empty($course_percent)) : ?>
            <div class="progress-title">
                <i class="fal fa-tasks"></i> درصد پیشرفت دوره: %<?php echo esc_html($course_percent); ?>
                <div class="meter animate">
                    <span style="width: <?php echo esc_html($course_percent); ?>%"><span></span></span>
                </div>
            </div>
        <?php endif; ?>


    <?php endif; ?>

</div>
<?php if ($course_counters) : ?>
    <?php wc_get_template_part('content', 'single-product-counter'); ?>
<?php endif; ?>
