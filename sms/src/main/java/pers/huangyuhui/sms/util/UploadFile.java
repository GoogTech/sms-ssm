package pers.huangyuhui.sms.util;

import org.apache.commons.io.filefilter.SuffixFileFilter;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.util.HashMap;
import java.util.Map;

/**
 * @project: sms
 * @description: 上传文件的工具类
 * @author: 黄宇辉
 * @date: 6/18/2019-10:45 AM
 * @version: 1.0
 * @website: https://yubuntu0109.github.io/
 */
public class UploadFile {

    //存储文件上传失败的错误信息
    protected static Map<String, Object> result = new HashMap<>();

    /**
     * @description: (抽取公共代码)效验所上传图片的大小及格式等信息...
     * @param: photo
     * @param: path
     * @date: 2019-06-18 11:01 AM
     * @return: java.util.Map<java.lang.String, java.lang.Object>
     */
    public static Map<String, Object> uploadPhoto(MultipartFile photo, String path) {
        //限制头像大小(20M)
        int MAX_SIZE = 20971520;
        //获取图片的原始名称
        String orginalName = photo.getOriginalFilename();
        //如果保存文件的路径不存在,则创建该目录
        File filePath = new File(path);
        if (!filePath.exists()) {
            filePath.mkdirs();
        }
        //限制上传文件的大小
        if (photo.getSize() > MAX_SIZE) {
            result.put("success", false);
            result.put("msg", "上传的图片大小不能超过20M哟!");
            return result;
        }
        // 限制上传的文件类型
        String[] suffixs = new String[]{".png", ".jpg", ".jpeg", ".gif", ".bmp"};
        SuffixFileFilter suffixFileFilter = new SuffixFileFilter(suffixs);
        if (!suffixFileFilter.accept(new File(path + orginalName))) {
            result.put("success", false);
            result.put("msg", "禁止上传此类型文件! 请上传图片哟!");
            return result;
        }

        return null;
    }
}
